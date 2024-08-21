defmodule ZenohElixir.Sub do
  def main do
    {:ok, session} = Zenohex.open()
    {:ok, subscriber} = Zenohex.Session.declare_subscriber(session, "key/expression")

    spawn(ZenohElixir.Sub, :subscribe, [subscriber])
  end

  def subscribe(subscriber) do
    case Zenohex.Subscriber.recv_timeout(subscriber) do
      {:error, :timeout} -> nil
      {:ok, msg} -> IO.puts "[sub.ex] " <> msg.value
    end

    subscribe(subscriber)
  end
end
