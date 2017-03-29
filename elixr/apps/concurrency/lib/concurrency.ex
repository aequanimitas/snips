defmodule Concurrency do
  @moduledoc """
  Documentation for Concurrency.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Concurrency.hello
      :world

  """
  def start(count) do
    pid0 = spawn(__MODULE__, :bar, [])
    spawn(__MODULE__, :foo, [pid0, count])
  end

  def foo(_pid, 0) do
    IO.puts "DONE"
  end

  def foo(pid, count) do
    send pid, {:foo, self()}
    receive do
      {:bar, _pid} ->
        IO.puts "Conversations remaining: #{count}"
        # recusion, tail-call optimization means the last computation that
        # needs to happen
        # is the recursive call
        foo(pid, count - 1)
    end
  end

  def bar do
    receive do
      {:foo, pid} ->
        IO.puts "foo received, sending back"
        send pid, {:bar, self()}
        bar()
    end
  end
end
