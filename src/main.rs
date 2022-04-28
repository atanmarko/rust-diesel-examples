mod schema;
mod db;

#[macro_use]
extern crate diesel;

pub const POOL_CONNECTION_SIZE: u32 = 3;

use diesel::pg::PgConnection;
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl};
use diesel::r2d2::{ConnectionManager};

use crate::db::Student;
use crate::schema::students::dsl::students;
use crate::schema::students::{address, age, date_of_birth, first_name, id, last_name};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("This is Rust diesel example!");

    //connect to database
    let database_url = std::env::var("DATABASE_URL").map_err(|e| Box::new(e))?;
    println!("Creating pool for database on url: {}", database_url);
    let database_pool = diesel::r2d2::Pool::builder()
        .max_size(POOL_CONNECTION_SIZE)
        .build(ConnectionManager::<PgConnection>::new(database_url))?;


    let conn = database_pool.get()?;

    // select id, first_name, last_name, address, age, date_of_birth from public.student;
    let result = students
        .select((id, first_name, last_name, address, age, date_of_birth))
        .load::<Student>(&conn)?;
    println!("select id, first_name, last_name, address, age, date_of_birth from public.student:\n {:#?}\n\n", result);


    // select count(*) from students where age=15;
    let result = students.filter(age.eq(15)).count().get_result::<i64>(&conn)?;
    println!("select count(*) from students where age=15:\n {:#?}\n\n", result);

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

    Ok(())
}
