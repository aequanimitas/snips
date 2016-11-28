defmodule Otp.Increment do
  def inc(x) do
    receive do
      :inc ->
        IO.puts "Increment! #{x}"
    end
    inc(x + 1)
  end

  def start do
    spawn(__MODULE__, :inc, [0])
  end
end
