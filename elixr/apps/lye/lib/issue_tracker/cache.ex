defmodule Lye.IssueTracker.Cache do
  use GenServer

  alias Lye.IssueTracker.Server
  alias Lye.IssueTracker.Database

  def init(_) do
    Database.start("./persist")
    {:ok, %{}}
  end

  def start do
    GenServer.start __MODULE__, nil
  end

  # callbacks

  ## create a new stateful server process if it doesn't exist
  def handle_call({:server_process, tracker_name}, _from, state) do
    case Map.has_key?(state, tracker_name) do
      true ->
        {:reply, Map.get(state, tracker_name), state}
      false ->
        {_, new_server} = Server.start({tracker_name, []})
        {:reply, new_server, Map.put(state, tracker_name, new_server)}
    end
  end

  def server_process(cache_pid, tracker_name) do
    GenServer.call cache_pid, {:server_process, tracker_name}
  end

  # naive benchmarking utils

  defp measure(cache_pid) do
    1..100_000
    |> Enum.to_list
    |> Enum.map(fn x ->
      server_process(cache_pid, "Server #{x}")
    end)
  end

  def start_measure(cache_pid) do
    :timer.tc(fn -> measure(cache_pid) end)
  end
end
