use crate::schema::*;
use chrono::{DateTime, Local, Utc};
use diesel::{backend::Backend, Insertable, Queryable};

// Nice mapping of Diesel to Rust types:
// https://kotiri.com/2018/01/31/postgresql-diesel-rust-types.html

/// Struct representing student in the database
#[derive(Insertable, Queryable, Debug, PartialEq)]
#[table_name = "students"]
pub struct Student {
    pub id: uuid::Uuid,
    pub first_name: String,
    pub last_name: String,
    pub address: String,
    pub age: Option<i64>,
    pub date_of_birth: Option<chrono::NaiveDate>,
}

/// Struct representing teacher in the database
#[derive(Insertable, Queryable, Debug, PartialEq)]
#[table_name = "teachers"]
pub struct Teacher {
    pub id: uuid::Uuid,
    pub first_name: String,
    pub last_name: String,
    pub degree: String,
    pub fully_employed: Option<bool>,
    #[diesel(deserialize_as = "LocalDateTimeWrapper")]
    pub contract_timestamp: chrono::DateTime<chrono::Local>, //timestamp with local timezone
}

pub struct LocalDateTimeWrapper(DateTime<Local>);
impl From<LocalDateTimeWrapper> for DateTime<Local> {
    fn from(wrapper: LocalDateTimeWrapper) -> DateTime<Local> {
        wrapper.0
    }
}
impl<DB, ST> Queryable<ST, DB> for LocalDateTimeWrapper
where
    DB: Backend,
    DateTime<Utc>: Queryable<ST, DB>,
{
    type Row = <DateTime<Utc> as Queryable<ST, DB>>::Row;
    fn build(row: Self::Row) -> Self {
        Self(<DateTime<Utc> as Queryable<ST, DB>>::build(row).with_timezone(&Local))
    }
}

#[derive(Insertable, Queryable, Debug, PartialEq)]
#[table_name = "subjects"]
pub struct Subject {
    pub index: i32,
    pub subject: String,
    pub teacher: Option<uuid::Uuid>,
}

#[derive(Insertable, Queryable, Debug, PartialEq)]
#[table_name = "grades"]
pub struct Mark {
    pub student: uuid::Uuid,
    pub subject: i32,
    pub grade: f32,
    pub time: chrono::NaiveTime,
}
