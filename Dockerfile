FROM rust:latest

COPY ./app-crashing-after-n-seconds ./

RUN cargo build --release

CMD ["./target/release/app-crashing-after-n-seconds", "45"]
