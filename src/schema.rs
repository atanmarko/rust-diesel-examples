table! {
    marks (student, subject, mark, time) {
        student -> Uuid,
        subject -> Int4,
        mark -> Float4,
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
        subject -> Varchar,
        teacher -> Nullable<Uuid>,
        index -> Int4,
    }
}

table! {
    teachers (id) {
        id -> Uuid,
        first_name -> Varchar,
        last_name -> Varchar,
        degree -> Varchar,
        fully_employed -> Nullable<Bool>,
        contract_timestamp -> Nullable<Timestamptz>,
    }
}

joinable!(marks -> students (student));
joinable!(marks -> subjects (subject));
joinable!(subjects -> teachers (teacher));

allow_tables_to_appear_in_same_query!(
    marks,
    students,
    subjects,
    teachers,
);
