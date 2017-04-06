defmodule Lye.KVStore do
  alias Lye.ServerProcess

  # helper function, abstraction that the ServerProcess is behind KVStore, 
  # supporting its operations
  def start do
    ServerProcess.start(__MODULE__)
  end

  # callback for server process
  def init do
    %{}
  end

  # interface functions
  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end

  def handle_call({:get, key}, state) do
    Map.get(state, key)
  end

  # fire-and-forget
  def put(pid, key, value) do
    ServerProcess.cast pid, {:put, key, value}
  end

  def get(pid, key) do
    ServerProcess.call pid, {:get, key}
  end
end
