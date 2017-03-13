defmodule Lye.Kitty.Server do
  
  alias Lye.Kitty.Cat

  @doc """
  Client API
  """
  def start_link do
    spawn_link __MODULE__, :init, [] #(fn -> &Lye.Kitty.Server.init/0 end)
  end

  @doc """
  Synchronous call.
  """
  def order_cat(pid, name, color, description) do
    ref = Process.monitor(pid)
    send pid, {self(), ref, {:order, name, color, description}}
    receive do
      {ref, cat} ->
        Process.demonitor(ref, [:flush])
        cat
      {'DOWN', ref, :process, pid, reason} ->
        :erlang.error(reason)
    after 5000 ->
      :erlang.error(:timeout)
    end
  end

  def return_cat(pid, cat) do
    send pid, {:return, cat}
    :ok
  end

  # synchronous call
  def close_shop(pid) do
    ref = Process.monitor(pid)
    send pid, {self(), ref, :terminate}
    receive do
      {ref, :ok} ->
        Process.demonitor(ref)
        :ok
      {'DOWN', _ref, :process, _pid, reason} ->
        :erlang.error(reason)
    after 5000 ->
      :erlang.error(:timeout)
    end
  end

  def init do
    loop []
  end

  def loop(cats) do
    IO.puts inspect cats
    receive do
      {pid, ref, {:order, name, color, description}} ->
        case Enum.empty?(cats) do
          true ->
            send pid, {ref, make_cat(name, color, description)}
            loop(cats)
          false ->
            send pid, {ref, hd(cats)}
            loop(tl(cats))
        end
      {:return, cat} ->
        # cons a new list?
        loop([cat | cats])
      {pid, ref, :terminate} ->
        send pid, {ref, :ok}
        terminate(cats)
      _ -> 
        IO.puts "Unknown message"
        loop(cats)
    end
  end

  def make_cat(name, color, description) do
    %Cat{name: name, color: color, description: description}
  end

  def terminate(cats) do
    for c <- cats, do: IO.puts "#{c.name} was set free"
    :ok
  end
end
