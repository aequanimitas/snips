defmodule Lye.IssueTracker.Database do
  use GenServer

  import Logger

  alias Lye.IssueTracker.DBWorker

  @doc """
  1-1 map to a persist file
  """

  def start(db_folder) do
    GenServer.start __MODULE__, db_folder, name: :database_server
  end

  # Callbacks

  def init(db_folder) do
    File.mkdir_p(db_folder)
    {_, worker1} = DBWorker.start(db_folder)
    {_, worker2} = DBWorker.start(db_folder)
    {_, worker3} = DBWorker.start(db_folder)
    pool = %{"0" => worker1, "1" => worker2, "2" => worker3}
    {:ok, pool}
  end

  def handle_cast({:store, key, data, worker}, pool) do
    DBWorker.store worker, key, data
    {:noreply, pool}
  end

  def handle_call({:get, key, worker}, _from, pool) do
    data = DBWorker.get worker, key
    {:reply, data, pool}
  end

  def handle_call({:get_worker, key}, _from, pool) do
    worker = Map.get(pool, "#{:erlang.phash2(key, 3)}")
    {:reply, worker, pool}
  end

  # Interface

  def store(key, data) do
    worker = get_worker(key)
    GenServer.cast :database_server, {:store, key, data, worker}
  end

  def get(key) do
    worker = get_worker(key)
    GenServer.call :database_server, {:get, key, worker}
  end

  defp get_worker(key) do
    GenServer.call :database_server, {:get_worker, key}
  end

  ## Naive benchmark
  # a billion takes a loooooong time to complete
  # trying this out to atleast have an idea on how long would the process be
  # blocked if it tries to do a million inserts concurrently, specially since
  # there's only a single process
  def million_requests do
    lst =
      1..1_000_000
      |> Enum.to_list
      |> Enum.map(&gen_data/1)
    :timer.tc(fn ->
      File.write!("test_input_data", :erlang.term_to_binary(lst))
    end)
  end

  def gen_data(x) do
    %{"id" => x, "name" => "#{x} name"}
  end
end
