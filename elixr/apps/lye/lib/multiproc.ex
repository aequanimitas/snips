defmodule Lye.Multiproc do
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
