defmodule ZenohElixir.Pub do
  def main do
    {:ok, session} = Zenohex.open()
    {:ok, publisher} = Zenohex.Session.declare_publisher(session, "key/expression")

    spawn(ZenohElixir.Pub, :publish, [publisher, 0])
  end

  def publish(publisher, num) do
    msg = "Hello from Elixir!! " <> to_string(num)
    IO.puts "[pub.ex] " <> msg

    Zenohex.Publisher.put(publisher, msg)

    Process.sleep(1000)
    publish(publisher, num + 1)
  end
end
