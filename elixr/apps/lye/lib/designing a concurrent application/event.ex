defmodule Lye.DCA.Event do
  @moduledoc """
  Read this again and take notes
  """

  alias Lye.DCA.State

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
        # in erlang, this is :erlang:monitor/2, need to explore more
        # find a way to handle the deadlock where the process is already
        # dead but
        ref = Process.monitor(pid)
        send pid, {self(), ref, :cancel}
        receive do
          {ref, :ok} ->
            Process.demonitor(ref, [:flush])
            :ok
          {:DOWN, _ref, _process, _pid, _reason} ->
            :ok
        end
    end
  end

  def loop(%State{server: server, to_go: [t | next], name: name}) do
    receive do
      {server, ref, :cancel} ->
        send server, {ref, :ok}
    after t * 1_000 ->
      if Enum.empty?(next) do
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
    # divide the time into 49 (days) equal parts, place in list
    [rem(n, limit) | n |> div(limit) |> List.duplicate(limit)]
  end

  # just handle the erlang's format for now and transfer to elixir's spec later
  def time_to_go({{_,_,_}, {_,_,_}} = timeout) do
    now = :calendar.local_time()
    togo = :calendar.datetime_to_gregorian_seconds(timeout) -
           :calendar.datetime_to_gregorian_seconds(now)
    secs = if togo > 0, do: togo, else: 0
    normalize(secs)
  end
end
