
use diesel::{Insertable, Queryable};
use crate::schema::*;

/// Struct representing Student in the database
#[derive(Insertable, Queryable, Debug, PartialEq)]
#[table_name = "students"]
pub struct Student {
    pub id: uuid::Uuid,
    pub first_name: String,
    pub last_name: String,
    pub address: String,
    pub age: Option<i64>,
    pub date_of_birth: Option<chrono::NaiveDate>
}