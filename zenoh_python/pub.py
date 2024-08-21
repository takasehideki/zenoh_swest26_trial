import zenoh, time

if __name__ == "__main__":
    session = zenoh.open()
    key = 'key/expression'
    pub = session.declare_publisher(key)
    t = 0
    while True:
        msg = "Hello from Python!! " + f"{t}"
        print(f"[pub.py] {msg}")
        pub.put(msg)
        time.sleep(1)
        t = t + 1
