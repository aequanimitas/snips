defmodule Lye.Kitty.MyServer do

  def start(module, initial_state) do
    spawn(fn -> init(module, initial_state) end)
  end

  def start_link(module, initial_state) do
    spawn_link(fn -> init(module, initial_state) end)
  end

  def init(module, initial_state) do
    loop(module, module.init(initial_state))
  end

  def reply({pid, ref}, reply) do
    send pid, {ref, reply}
  end

  # sync
  def call(pid, msg) do
    IO.puts "inside call/2"
    IO.puts inspect pid
    ref = Process.monitor(pid)
    IO.puts "inside call/2"
    IO.puts inspect ref
    send pid, {:sync, self(), ref, msg}
    receive do
      {ref, reply} ->
        Process.demonitor(pid, [:flush])
        reply
      {:DOWN, ref, :process, pid, reason} ->
        :erlang.error(reason)
    after 5000 ->
      :erlang.error(:timeout)
    end
  end

  # async
  def cast(pid, msg) do
    send pid, {:async, msg}
    :ok
  end

  # cater every message, sync or async
  def loop(module, state) do
    receive do
      {:async, msg} ->
        loop(module, module.handle_cast(msg, state))
      {:sync, pid, ref, msg} ->
        # still needs to know about references when sending sync messages
        # unclear right now re: abstraction on this part
        # loop(module, module.handle_call(msg, pid, ref, state)
        loop(module, module.handle_call(msg, {pid, ref}, state))
    end
  end
end
