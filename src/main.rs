use std::env;
use std::path::Path;
use std::thread;
use std::time::Duration;
use tracing::{error, info, Level};
use tracing_subscriber::FmtSubscriber;

fn main() {
    // This program reads a file path from ENV and check if file exists
    // if doesn't exist, it stops, otherwise it just prints 'File {} exists'.
    
    // init logger
    let subscriber = FmtSubscriber::builder()
        .with_max_level(Level::INFO)
        .finish();

    tracing::subscriber::set_global_default(subscriber).expect("setting default subscriber failed");

    match env::var("APP_FILE_PATH_TO_BE_CHECKED") {
        Err(e) => {
            error!("Error APP_FILE_PATH_TO_BE_CHECKED is not set: {}", e);
        },
        Ok(v) => {
            if !Path::new(&v).exists() {
                error!("Error: file {}, doesn't exist", &v);
                return;
            }

            loop {
                info!("File `{}` exists !", &v);
                thread::sleep(Duration::from_secs(5));
            }
        }
    }
}
