# Chapter 13: Designing a Concurrent Application

defmodule Elixr.Lysefgg.DCA.State do
  defstruct server: nil, name: "", to_go: 0
end

defmodule Elixr.Lysefgg.DCA.Event do

  alias Elixr.Lysefgg.DCA.State

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
end
