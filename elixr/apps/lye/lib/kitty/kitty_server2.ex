defmodule Lye.Kitty.ServerTwo do
  alias Lye.Kitty.Cat
  alias Lye.Kitty.MyServer

  def start_link do
    spawn_link(fn -> MyServer.start_link(__MODULE__, []) end)
  end

  # synchronous call
  def order_cat(pid, name, color, description) do
    IO.puts "inside order_cat"
    IO.puts inspect pid
    MyServer.call(pid, {:order, name, color, description})
  end

  # async, not blocking, no immediate ```receive``` calls 
  def return_cat(pid, cat) do
    # Let MyServer handle message sending
    # send pid, {:return, cat}
    # :ok
    MyServer.cast(pid, {:return, cat})
  end

  def close_shop(pid) do
    MyServer.call(pid, :terminate)
  end

  def init([]), do: []

  def handle_call({order, name, color, description}, from, cats) do
    IO.puts "kittt_server2 handle_call reached"
    case Enum.empty?(cats) do
      true ->
        MyServer.reply(from, make_cat(name, color, description))
        cats
      false ->
        MyServer.reply(from, hd(cats))
        tl(cats)
    end
  end

  def handle_call(:terminate, from, cats) do
    MyServer.reply(from, :ok)
    terminate(cats)
  end

  def handle_cast({:return, cat}, cats) do
    [cat | cats]
  end

  def make_cat(name, color, description) do
    %Cat{name: name, color: color, description: description}
  end

  def terminate(cats) do
    for c <- cats, do: IO.puts "#{c.name} was set free"
    exit(:normal)
  end
end
