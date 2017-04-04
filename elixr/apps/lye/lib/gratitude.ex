defmodule Lye.Gratitude do
  @doc """
  Interface functions
  """
  def start do
    spawn __MODULE__, :gratitude_list, [[]]
  end

  def pool(range, pid \\ nil) do
    pids = range |> Enum.map(fn _x ->
      pid = if is_nil(pid) do
        start()
      else
        pid
      end
      add(pid, "I am alive #{current_datetime()}")
      pid
    end)
    pids
  end

  def current_datetime do
    {{year, month, day}, {hour, minutes, seconds}} = :calendar.local_time
    "#{year}/#{month}/#{day} -- #{hour}:#{minutes}:#{seconds}"
  end

  @doc """
  Store all received messages in the mailbox of a process. Since processes are
  sequential in nature, all messages will be processed one by one
  """
  def start_sequential_processing(pid) do
    pool(1..1000, pid)
  end

  @doc """
  Store all received messages in the mailbox of each spawned process. Processes
  are sequential in nature.
  """
  def start_concurrent_processing do
    pool(1..1000)
  end

  def add(pid, item) do
    send pid, {self(), {:add, item}}
    receive do
      {:ok, _pid, item} ->
        IO.puts "item #{item} added"
        :ok
    after 3000 ->
      :timeout
    end
  end

  def all(pid) do
    send pid, {self(), :list_all}
    receive do
      lst ->
        grateful_things = Enum.join(lst, ", ")
        IO.puts "You are thankful because you are: " <> grateful_things
        :ok
    after 3000 ->
      :timeout
    end
  end

  def gratitude_list(lst) do
    receive do
      {from, {:add, item}} ->
       # send confirmation that message was received
       send from, {:ok, self(), item}
       gratitude_list [item | lst]
      {from, :list_all} ->
        send from, lst
        gratitude_list lst
    end
  end
end
