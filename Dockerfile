FROM rust as builder
WORKDIR /usr/src/app
COPY . .
RUN cargo install --path .

FROM debian:buster-slim
RUN apt-get update && apt-get install -y pkg-config libssl-dev ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/app-crashing-if-file-doesnt-exist /usr/local/bin/app-crashing-if-file-doesnt-exist
CMD ["app-crashing-if-file-doesnt-exist"]
