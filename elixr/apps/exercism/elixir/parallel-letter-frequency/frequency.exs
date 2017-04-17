defmodule Frequency.Worker do
  use GenServer

  ## Interfaces

  def start do
    GenServer.start __MODULE__, 0
  end

  ## callbacks
end

defmodule Frequency.Dispatcher do
  use GenServer

  ## Interfaces
  def start do
    GenServer.start __MODULE__, nil, name: :dispatcher
  end 

  def inc(key) do
    key = String.trim(key) |> String.downcase
    cond do
      String.length(key) == 0 -> GenServer.call :dispatcher, {:all}
      String.length(key) > 1 -> 
        lst = String.split(key, "", trim: true)
        Enum.each(lst, fn x ->
          GenServer.cast :dispatcher, {:inc, x}
        end)
      String.length(key) == 1 -> GenServer.cast :dispatcher, {:inc, key}
    end
  end

  def all do
    GenServer.call :dispatcher, {:all}
  end

  ## Callbacks

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:inc, key}, state) do
    if Map.has_key?(state, key) do
      new_map = %{state | key => state[key] + 1}
      {:noreply, Map.merge(state, new_map)} 
    else
      {:noreply, Map.merge(state, %{key => 1})} 
    end
  end

  def handle_call({:all}, _from, state) do
    {:reply, state, state} 
  end
end

defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  alias Frequency.Dispatcher

  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    case length(texts) > 0 do
      true ->
        Enum.each(texts, fn x ->
          Dispatcher.inc(x)
        end)
        Dispatcher.all()
      false -> []
    end
  end
end
