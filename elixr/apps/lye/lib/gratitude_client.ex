defmodule Lye.GratitudeClient do
  alias Lye.ServerProcess

  def start do
    ServerProcess.start(__MODULE__)
  end

  def init do
    []
  end

  def handle_cast({:add, value}, state) do
    [value | state] 
  end

  def handle_call(:all, state) do
    state
  end

  def add(pid, value) do
    ServerProcess.cast pid, {:add, value}
  end

  def all(pid) do
    ServerProcess.call pid, :all
  end
end
