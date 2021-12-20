use std::env;
use std::io::{self, Write};
use std::{thread, time};

fn main() -> io::Result<()> {
    let args: Vec<String> = env::args().collect();

    let running_for_n_seconds: u64 = args[1].parse().expect("first arguments should be a u64! Number of seconds until the prgram crashes.");
    let running_for_n_seconds = time::Duration::from_secs(running_for_n_seconds);

    let started = time::Instant::now();
    let stdout = io::stdout();

    loop {
        let mut handle = stdout.lock();
        handle.write_all(b"I am running\n")?;


        if started.elapsed() >= running_for_n_seconds {
            break;
        }

        thread::sleep(time::Duration::from_secs(1));
    }


    let mut handle = stdout.lock();
    handle.write_all(b"I am crashing now\n")?;

    Err(std::io::Error::new(io::ErrorKind::Other, "done!".to_string()))

}
