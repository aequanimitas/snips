defmodule Lye.IssueTracker.Database do
  use GenServer

  @doc """
  1-1 map to a persist file
  """

  def start(db_folder) do
    GenServer.start __MODULE__, db_folder, name: :database_server
  end

  # Callbacks

  def init(db_folder) do
    File.mkdir_p(db_folder)
    {:ok, db_folder}
  end

  def handle_cast({:store, key, data}, db_folder) do
    db_folder
    |> file_name(key)
    |> File.write!(:erlang.term_to_binary(data))
    {:noreply, db_folder}
  end

  def handle_call({:get, key}, _from, db_folder) do
    data = case File.read(file_name(db_folder, key)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end
    {:reply, data, db_folder}
  end

  # Interface

  def store(key, data) do
    GenServer.cast :database_server, {:store, key, data}
  end

  def get(key) do
    GenServer.call :database_server, {:get, key}
  end

  # utils
  defp file_name(db_folder, {name, _initial_state}), do: "#{db_folder}/#{name}"

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
