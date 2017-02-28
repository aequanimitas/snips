# Chapter 13: Designing a Concurrent Application

defmodule Elixr.Lysefgg.DCA.State do
  defstruct server: nil, name: "", to_go: 0
end

defmodule Elixr.Lysefgg.DCA.Event do

  alias Elixr.Lysefgg.DCA.State

  # interfaces for end-users, not programmers

  # standard: begin with functions ```start``` and ```start_link```
  def start(event_name, delay) do
    spawn __MODULE__, :init, [self(), event_name, delay]
  end

  def start_link(event_name, delay) do
    spawn_link __MODULE__, :init, [self(), event_name, delay]
  end

  # standard: add ```init``` to encapsulate initializations
  def init(server, event_name, delay) do
    loop %State{server: server, name: event_name, to_go: time_to_go(delay)}
  end

  # the only message that we can send can have it's own interface
  def cancel(pid) do
    case Process.info(pid) do
      nil -> 
        IO.puts "Process doesn't exist"
        :ok
      _ ->
        ref = Process.monitor(pid) # in erlang, this is :erlang:monitor/2, need to explore more
                                   # find a way to handle the deadlock where the process is already
                                   # dead but 
        send pid, {self(), ref, :cancel}
        receive do
          {ref, :ok} ->
            Process.demonitor(ref, [:flush])
            :ok
          {'DOWN', _ref, _process, _pid, _reason} ->
            :ok
        end
    end
  end

  def loop(%State{server: server, to_go: [t | next], name: name}) do
    receive do
      {server, ref, :cancel} ->
        send server, {ref, :ok}
    after t * 1_000 ->
      if (next == []) do
        send server, {:done, name} 
      else
        # in the book, a record was passed where to_go was only changed
        %State{to_go: next, server: server, name: name}
        |> loop
      end
    end
  end

  # erlang can only handle 50 days in milliseconds, this one is a workaround
  def normalize(n) do
    limit = 49 * 24 * 60 * 60  # calculate seconds for 49 days
    [rem(n, limit) |
     div(n, limit)
     |> List.duplicate(limit)] # divide the time into 49 (days) equal parts, place in list
  end

  # just handle the erlang's format for now and transfer to elixir's spec later
  def time_to_go(timeout = {{_,_,_}, {_,_,_}}) do
    now = :calendar.local_time()
    togo = :calendar.datetime_to_gregorian_seconds(timeout) - 
           :calendar.datetime_to_gregorian_seconds(now)
    secs = if togo > 0, do: togo, else: 0
    normalize(secs)
  end
end

defmodule Elixr.Lysefgg.DCA.Evserv.State do
  defstruct events: nil, clients: nil
end

defmodule Elixr.Lysefgg.DCA.Evserv.Event do
  # timeout is {{Year, Month, Day}, {Hours, Minutes, Seconds}}
  defstruct name: "", description: "", pid: nil, timeout: {{1970,0,0}, {0,0,0}}
end

defmodule Elixr.Lysefgg.DCA.Evserv do
  @moduledoc """
  Keep track of two things:
  - list of clients
  - list of processes spawned
  """
  
  alias Elixr.Lysefgg.DCA.Evserv.Event, as: EvEvent
  alias Elixr.Lysefgg.DCA.Evserv.State, as: EvState
  alias Elixr.Lysefgg.DCA.Event, as: Event

  def init do
    # leverage erlang code when necessarry, and this is one of those times where
    # you need something that is not in Elixir. 
    loop %EvState{events: :orddict.new(), clients: :orddict.new()}
  end

  # Main receiver for this module, all messages are caught and handled by this function
  def loop(evstate = %EvState{events: events, clients: clients}) do
    receive do
      # handle subcribe messages
      {pid, msg_ref, {:subscribe, client}} ->
        # monitor client, user will be notified when it crashes
        # this is also async, so it takes time before the signal reaches its receiver
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
            events = :orddict.store(name, %EvEvent{name: name,
                                                       description: description,
                                                       pid: event_pid,
                                                       timeout: timeout}, events)
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
            send_to_clients({:done, event.name, event.description}, evstate.clients)
            events = :orddict.erase(name, evstate.events)
            loop %{evstate | events: events}
          :error ->
            loop evstate
        end

      :shutdown -> exit(:shutdown)
      {"DOWN", ref, :process, _pid, _reason} -> 
        loop %{evstate | clients: :orddict.erase(ref, clients)}
      # by using the pattern __MODULE__.fn (fully qualified calls) we can call the loop
      # loop in new version of code, if exists
      :code_change -> __MODULE__.loop evstate 
      _ ->
        IO.puts "Unknown message"
        loop evstate
    end
  end

  def send_to_clients(msg, clients) do
    :orddict.map(fn(_ref, pid) -> send pid, {msg, :end} end, clients)
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
  def start() do
    pid = spawn(__MODULE__, :init, [])
    Process.register(pid, __MODULE__)
    pid
  end

  def start_link() do
    pid = spawn_link(__MODULE__, :init, [])
    Process.register(pid, __MODULE__)
    pid
  end

  def terminate() do
    send __MODULE__, :shutdown
  end

  # abstraction for subscribing
  def subscribe(pid) do
    ref = Process.monitor(pid)
    send __MODULE__, {self(), ref, {:subscribe, pid}}
    receive do
      {ref, :ok} ->
        {:ok, ref}
      {"DOWN", _ref, :process, _pid, reason} ->
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
      message = {_done, _name, _description} ->
        [message | listen(0)]
    after delay * 1000 ->
      []
    end
  end
end
