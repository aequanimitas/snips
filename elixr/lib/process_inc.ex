defmodule Elixr.Process.Increment do

  # just increment
  # same with the Elixr.Etex.Worker, loops and waits for another meesage
  def inc(x) do
    receive do
      {:increase, pid} ->
        IO.puts "Increment! #{x}"
        send pid, {:increased, self()}
    end
  end

  # start with 0, returns reference to current module and fn, passing 0 as initial argument
  def start do
    spawn(__MODULE__, :inc, [0])
  end
end
