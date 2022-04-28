mod db;
mod schema;

#[macro_use]
extern crate diesel;

pub const POOL_CONNECTION_SIZE: u32 = 3;

use diesel::pg::PgConnection;
use diesel::r2d2::ConnectionManager;
use diesel::{
    dsl::sql,
    sql_types::{Double, Int8, Text, Uuid},
    ExpressionMethods, QueryDsl, RunQueryDsl, TextExpressionMethods,
};

use crate::db::{Student, Subject, Teacher};
use crate::schema::grades::dsl::grades;
use crate::schema::students::dsl::students;
use crate::schema::students::{address, age, date_of_birth, first_name, id, last_name};
use crate::schema::subjects::dsl::*;
use crate::schema::subjects::subject;
use crate::schema::teachers::dsl::*;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("This is Rust diesel example!");

    //connect to database
    let database_url = std::env::var("DATABASE_URL").map_err(|e| Box::new(e))?;
    println!("Creating pool for database on url: {}", database_url);
    let database_pool = diesel::r2d2::Pool::builder()
        .max_size(POOL_CONNECTION_SIZE)
        .build(ConnectionManager::<PgConnection>::new(database_url))?;

    let conn = database_pool.get()?;

    // select id, first_name, last_name, address, age, date_of_birth from public.students order by first_name asc;
    let result = students
        .select((id, first_name, last_name, address, age, date_of_birth))
        .order(first_name.asc())
        .load::<Student>(&conn)?;
    println!("select id, first_name, last_name, address, age, date_of_birth from public.student:\n {:#?}\n\n", result);

    // select * from teachers limit 3
    let result = teachers.limit(3).load::<Teacher>(&conn)?;
    println!("Teachers:\n {:#?}\n\n", result);

    // select * FROM public.subjects where subject like 'M%';
    let result = subjects.filter(subject.like("M%")).load::<Subject>(&conn)?;
    println!("Subjects starting on M:\n {:#?}\n\n", result);

    // select count(*) from students where age=15;
    let result = students
        .filter(age.eq(15))
        .count()
        .get_result::<i64>(&conn)?;
    println!(
        "select count(*) from students where age=15:\n {:#?}\n\n",
        result
    );

    // select first_name, last_name, date_of_birth from public.students where age>14 and age<17;
    let result = students
        .select((first_name, last_name, date_of_birth))
        .filter(age.gt(14))
        .filter(age.lt(17))
        .load::<(String, String, Option<chrono::NaiveDate>)>(&conn)?;
    for (name, surname, birthday) in result {
        if let Some(birthday) = birthday {
            println!("Kid {} {} has birthday on {}", name, surname, birthday);
        }
    }

    // select s.first_name as student_name, s.last_name as student_surname,
    // m.mark from public.students as s, public.marks as m
    // where s.id=m.student and s.first_name='Anita';
    let result = students
        .inner_join(grades)
        .select((
            schema::students::columns::first_name,
            schema::students::columns::last_name,
            schema::grades::columns::grade,
        ))
        .filter(schema::students::columns::first_name.eq("Anita"))
        .load::<(String, String, f32)>(&conn)?;

    println!(
        "select s.first_name as student_name, s.last_name as student_surname\n \
     m.mark from public.students as s, public.marks as m \
     where s.id=m.student and s.first_name='Anita': \n {:#?}\n\n",
        result
    );

    // Get average mark of every student
    // select s.first_name as student_name, s.last_name as student_surname,
    // avg(g.grade) from public.students as s, public.grades as g
    // where s.id=g.student
    // group by s.first_name, s.last_name;
    //
    // group_by support is missing in Diesel 1.x https://github.com/diesel-rs/diesel/issues/210
    let result = students
        .inner_join(grades)
        .select((
            schema::students::columns::first_name,
            schema::students::columns::last_name,
            sql::<Double>("avg(grades.grade) AS grade"),
        ))
        .filter(diesel::dsl::sql(
            "true group by students.first_name, students.last_name",
        ))
        .load::<(String, String, f64)>(&conn)?;
    println!("Average student mark: \n {:#?}\n\n", result);

    // Use raw sql in queries
    let result = students
        .select((
            sql::<Uuid>("id as Identification"),
            sql::<Text>("first_name as Name"),
            sql::<Int8>("age*2 as DoubleAge"),
        ))
        .load::<(uuid::Uuid, String, i64)>(&conn)?;
    println!("Custom sql:\n {:#?}\n\n", result);

    // Insert new student
    let new_student = Student {
        id: uuid::Uuid::new_v4(),
        first_name: "James".to_string(),
        last_name: "Bond".to_string(),
        age: Some(18),
        address: "Wellington Square 10, Chelsea".to_string(),
        date_of_birth: Some(chrono::NaiveDate::from_ymd(2004, 3, 14)),
    };
    match diesel::insert_into(students)
        .values(new_student)
        .execute(&conn)
    {
        Ok(val) => {
            println!("Successfully inserted new student to database! {}", val);
        }
        Err(e) => {
            println!("Failed to insert new student {}!", e.to_string());
        }
    }

    // Update all James Bond student
    let result = diesel::update(
        students
            .filter(first_name.eq("James"))
            .filter(last_name.eq("Bond")),
    )
    .set((age.eq(19), address.eq("Unknown address")))
    .get_result::<Student>(&conn)?;
    println!("Result of student update: {:?}", result);

    Ok(())
}
