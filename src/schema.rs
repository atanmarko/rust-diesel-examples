table! {
    grades (student, subject, grade, time) {
        student -> Uuid,
        subject -> Int4,
        grade -> Float4,
        time -> Time,
    }
}

table! {
    students (id) {
        id -> Uuid,
        first_name -> Varchar,
        last_name -> Varchar,
        address -> Varchar,
        age -> Nullable<Int8>,
        date_of_birth -> Nullable<Date>,
    }
}

table! {
    subjects (index) {
        index -> Int4,
        subject -> Varchar,
        teacher -> Nullable<Uuid>,
    }
}

table! {
    teachers (id) {
        id -> Uuid,
        first_name -> Varchar,
        last_name -> Varchar,
        degree -> Varchar,
        fully_employed -> Nullable<Bool>,
        contract_timestamp -> Timestamptz,
    }
}

joinable!(grades -> students (student));
joinable!(grades -> subjects (subject));
joinable!(subjects -> teachers (teacher));

allow_tables_to_appear_in_same_query!(
    grades,
    students,
    subjects,
    teachers,
);
