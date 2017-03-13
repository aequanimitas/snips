defmodule Lysefgg.Kitchen do
  @doc """
  Food can be taken only as many times as it was stored. Initial implementation starts as
  stateless. 

  ## Examples
  iex> pid = spawn(Elixr.Lysefgg.Kitchen, :fridge1, [])
  iex> send pid, {self(), {:store, "milk"}}
  {#PID<0.192.0>, {:store, "milk"}}
  iex> flush()
  {#PID<0.277.0>, :ok}
  :ok
  iex> send pid, {self(), {:take, "milk"}}
  {#PID<0.192.0>, {:take, "milk"}}
  iex> flush()
  {#PID<0.277.0>, :not_found}
  :ok
  """
  def fridge1 do
    receive do
      {sender, {:store, _food}} ->
        # read as send to sender my process id, in case you want to communicate more, and
        # also my message :ok
        send sender, {self(), :ok}
        fridge1()
      {sender, {:take, _food}} ->
        send sender, {self(), :not_found}
        fridge1()
      _ ->
        IO.puts "Kitchen.fridge1 received"
        :ok
    end
  end

  @doc """
  Now we store state on food_list. The list is maintained internally by
  this process. The protocol (:store, :take) is explicitly passed by the messenger along
  with its message
  """
  def fridge2(food_list) do
    receive do
      {sender, {:store, food}} ->
        send sender, {self(), :ok}
        fridge2([food | food_list])
      {sender, {:take, food}} ->
        case Enum.member?(food_list, food) do
          true -> 
            # always send a message first before recursing to avoid deadlock
            send sender, {self(), :ok}
            fridge2(List.delete(food_list, food))
          false -> 
            send sender, {self(), :not_found}
            fridge2(food_list)
        end
      terminate ->
        :ok
    end
  end

  @doc """
  Hide implementation details and just pass the process id and message. I guess this is
  already CQRS. Let fridge2 handle the calls, and self() maps to the PID of the caller(?)
  """
  def store(pid, food) do
    send pid, {self(), {:store, food}}
    receive do
      {_sender, message} -> message
    end
  end
  
  def take(pid, food) do
    send pid, {self(), {:take, food}}
    receive do
      {_sender, message} -> message
    end
  end

  @doc """
  Add helper fn for spawning the process, assists the end-user so that they don't do
  any new calls
  """
  def start(), do: spawn(__MODULE__, :fridge2, [[]])
  def start([]), do: spawn(__MODULE__, :fridge2, [[]])
  def start(food_list), do: spawn(__MODULE__, :fridge2, [food_list])

  @doc """
  In case of deadlock, show error to user. The ```after``` will be triggered when no pattern
  mathes the Match pattern. Time in ```after``` can be set to ```infinity```, useful when
  a result ix expected, even if it is an error.
  """
  def store2(pid, food) do
    send pid, {self(), {:store, food}}
    receive do
      {_sender, message} -> message
    after 3000 ->
      :timeout
    end
  end
  
  def take2(pid, food) do
    send pid, {self(), {:take, food}}
    receive do
      {_sender, message} -> message
    after 3000 ->
      :timeout
    end
  end
end

defmodule Elixr.Lysefgg.Multiproc do
  @doc """
  In this case, nothing will match the ```receive``` and ```after``` will immediately run
  """
  def sleep(t) when is_integer(t) == false, do: :not_ok
  def sleep(t) do
    receive do
      _ -> nil
    after t ->
      :ok
    end
  end

  # as long as there are messages, flush will be called recursively until the mailbox
  # is not empty
  def flush() do
    receive do
      _ -> flush()
    after 0 ->
      :ok
    end
  end

  @doc """
  Start of selective receive.

  This is new to me, where ```important``` and ```normal``` are like global receive. I'm
  not sure on what the proper term for this. Doing a ```send``` to ```self()``` accumulates
  all the messages
  """
  def important do
    receive do
      {priority, message} when priority > 10 ->
        # push message into list, then do a recursive call again for important() ???
        [message | important()]
    after 0 ->
      # now if priority is less than ten, call ```normal()```
      normal()
    end
  end

  def normal do
    receive do
      {_, message} ->
        # push message into list, then do a recursive call again for normal() ???
        [message | normal()]
    after 0 ->
      []
    end
  end

  def unexpected_message do
    receive do
      {alert_level, message} when alert_level > 4 -> 
        IO.puts "Alert level #{alert_level}: #{message}"
      _ ->
        IO.puts "Alert level beyond"
    end
  end
end

defmodule Elixr.Lysefgg.MultiprocTwo do
  def blah do
    receive do
      # when you do a send() to self(), this triggers too
      {_, message} -> IO.puts "Multiproc2: #{message}"
       _ -> IO.puts "Multiproc2"
    after 0 -> :ok
    end
  end
end