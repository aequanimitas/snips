defmodule Elixr.Ping do
  def start do
    await
  end

  def await do
    receive do
      {:pong, pid} ->
        send pid, {:ping, self}
    end
    # call again here to process more messages
    await
  end
end

