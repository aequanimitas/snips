defmodule Lye.DCA.Evserv do
  @moduledoc """
  Keep track of two things:
  - list of clients
  - list of processes spawned
  """

  alias Lye.DCA.Evserv.Event, as: EvEvent
  alias Lye.DCA.Evserv.State, as: EvState
  alias Lye.DCA.Event, as: Event

  def init do
    # leverage erlang code when necessarry, and this is one of those times where
    # you need something that is not in Elixir.
    loop %EvState{events: :orddict.new(), clients: :orddict.new()}
  end

  @doc """
  Main receiver for this module, all messages are caught and handled by
  this function
  """
  def loop(%EvState{events: events, clients: clients} = evstate) do
    receive do
      # handle subcribe messages
      {pid, msg_ref, {:subscribe, client}} ->
        # monitor client, user will be notified when it crashes
        # this is also async, so it takes time before the signal
        # reaches its receiver
        ref = Process.monitor(client)
        # add client to subscribers, will be notified when an event is done
        new_clients = :orddict.store(ref, client, clients)
        send pid, {msg_ref, :ok}
        loop %{evstate | clients: new_clients}

      # handling add event messages
      {pid, msg_ref, {:add, name, description, timeout}} ->
        case valid_datetime(timeout) do
          true ->
            event_pid = Event.start_link(name, timeout)
            ev_event = %{
              name: name,
              description: description,
              pid: event_pid,
              timeout: timeout
            }
            ev_event = Map.merge(ev_event, %EvEvent{})
            events = :orddict.store(name, ev_event, events)
            send pid, {msg_ref, :ok}
            loop %{evstate | events: events}
          {:error, reason} ->
            send pid, {msg_ref, {:error, reason}}
            loop evstate
        end

      # cancelling an event, check if event is in list
      {pid, msg_ref, {:cancel, name}} ->
        events = case :orddict.find(name, events) do
                   {:ok, e} ->
                     Event.cancel(e.pid)
                     :orddict.erase(name, events)
                   :error ->
                     events
                 end
        send pid, {msg_ref, :ok}
        loop %{evstate | events: events}

      {:done, name} ->
        case :orddict.find(name, events) do
          {:ok, event} ->
            done_msg = {:done, event.name, event.description}
            send_to_clients(done_msg, evstate.clients)
            events = :orddict.erase(name, evstate.events)
            loop %{evstate | events: events}
          :error ->
            loop evstate
        end

      :shutdown -> exit(:shutdown)
      {:DOWN, ref, :process, _pid, _reason} ->
        loop %{evstate | clients: :orddict.erase(ref, clients)}
      # by using the pattern __MODULE__.fn (fully qualified calls)
      # we can call the loop in new version of code, if exists
      :code_change -> __MODULE__.loop evstate
      _ ->
        IO.puts "Unknown message"
        loop evstate
    end
  end

  def send_to_clients(msg, clients) do
    :orddict.map(fn(_ref, pid) -> send pid, msg end, clients)
  end

  def valid_datetime({date, time}) do
    with true <- :calendar.valid_date(date),
         true <- valid_time(time)
    do
      true
    else
      error -> error
    end
  end

  # you can do more abstractions here but I opt not to, too much code for a
  # very basic functionality
  def valid_time({h,m,s}) when h >= 0 and h < 24 and
                               m >= 0 and m < 60 and
                               s >= 0 and s < 60, do: true

  # do a catch all here instead of matching each element
  def valid_time(_), do: {:error, "invalid format"}

  # interfaces start here
  def start do
    pid = spawn(__MODULE__, :init, [])
    Process.register(pid, __MODULE__)
    pid
  end

  def start_link do
    pid = spawn_link(__MODULE__, :init, [])
    Process.register(pid, __MODULE__)
    pid
  end

  def terminate, do: send __MODULE__, :shutdown

  # abstraction for subscribing
  def subscribe(pid) do
    ref = Process.monitor(pid)
    send __MODULE__, {self(), ref, {:subscribe, pid}}
    receive do
      {ref, :ok} ->
        {:ok, ref}
      {:DOWN, _ref, :process, _pid, reason} ->
        {:error, reason}
    after 5000 ->
        {:error, :timeout}
    end
  end

  def add_event(name, description, timeout) do
    ref = make_ref()
    send __MODULE__, {self(), ref, {:add, name, description, timeout}}
    receive do
      {_ref, msg} -> msg
    after 5000 ->
      {:error, :timeout}
    end
  end

  # crashing version of add_event
  def add_event2(name, description, timeout) do
    ref = make_ref()
    send __MODULE__, {self(), ref, {:add, name, description, timeout}}
    receive do
      {_ref, {:error, reason}} -> :erlang.error(reason)
      {_ref, msg} -> msg
    after 5000 ->
      {:error, :timeout}
    end
  end

  # cancellation
  def cancel(name) do
    ref = make_ref()
    send __MODULE__, {self(), ref, {:cancel, name}}
    receive do
      {_ref, :ok} -> :ok
    after 5000 ->
      {:error, :timeout}
    end
  end

  def listen(delay) do
    receive do
      message = {:done, _name, _description} ->
        [message | listen(0)]
    after delay * 1000 ->
      []
    end
  end
end
