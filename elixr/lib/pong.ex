defmodule Elixr.Pong do
  @moduledoc false
  def start do
    await 0
  end

  def await(ct) do
    receive do
      {:ping, pid} ->
        send pid, {:pong, self}
    end
    # call again here to process more messages
    IO.puts "Pong receive ping #{ct} times"
    await ct + 1
  end
end
