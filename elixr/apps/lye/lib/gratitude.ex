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

  @doc """
  Seperate functions that do state mutations from sending messages
  """
  def add(pid, item) do
    # subtle message for LIFO
    send pid, {self(), {:add, item}}
    receive do
      {:ok, _, item} ->
        IO.puts "thankful that: #{item}"
    after 3000 ->
      :timeout
    end
  end

  @doc """
  Seperate functions that do state mutations from sending messages
  """
  def remove(pid, item) do
    send pid, {self(), {:add, item}}
  end

  def all(pid) do
    send pid, {self(), :list_all}
    receive do
      {:ok, _, lst} ->
        grateful_things = Enum.join(lst, ", ")
        IO.puts "You are thankful because: " <> grateful_things
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
      {from, {:remove, item}} ->
        lst = Enum.reduce(lst, [], fn x, acc ->
          case x !== item do
            true -> [item | acc]
            false -> acc
          end
        end)
        send from, {:ok, self(), lst}
        gratitude_list lst
      {from, :list_all} ->
        send from, {:ok, self(), lst}
        gratitude_list lst
      # add a catch all clause so messages that doesn't match the general 
      # pattern doesn't get placed in the save queue and pushed again to the
      # mailbox
      message ->
        IO.puts "Unknown message: #{inspect message}"
        gratitude_list lst
    end
  end
end
