# rust-diesel-examples
Rust Diesel PostgreSQL examples

When I used Diesel with PostgreSQL for the first time, I faced with the lack of complete working code examples. Here I have tried to assemble some convenient example use-cases in one place.


## Setup


Install diesel cli:
```shell
cargo install diesel_cli --no-default-features --features postgres
```

Set URL to database
```shell
export DATABASE_URL=postgres://<postgres_username>:<postgres_password>@<postgres_host>:<postgres_port>/school
```

Perform migrations. At this step Rust schema is also automatically generated and printed to the file defined in `diesel.toml`
```shell
diesel setup
diesel migration run
```



## Execute

Put database in vanilla state
```shell
diesel migration redo
```

Run example binary that will query, insert and update tables
```shell
cargo run
```


## Tables diagram

![alt text](./Diagram.png)