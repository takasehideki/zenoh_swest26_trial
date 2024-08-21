use zenoh::prelude::r#async::*;

use ctrlc_handler::CtrlCHandler;
use std::{thread, time};

#[async_std::main]
async fn main() {
    let session = zenoh::open(config::peer()).res().await.unwrap().into_arc();
    let publisher = session.declare_publisher("key/expression").res().await.unwrap();

    let msg_header = String::from("Hello from Rust!! ");
    let mut index = 0;
    let handler = CtrlCHandler::new();
    while handler.should_continue() {
        let msg: String = format!("{}{}", msg_header, index.to_string());
        println!("[pub.rs] {}", msg);

        publisher.put(msg).res().await.unwrap();

        thread::sleep(time::Duration::from_millis(1000));
        index += 1;
    }

    publisher.delete().res().await.unwrap();
}
