defmodule Lye.IssueTracker.Server do
  use GenServer

  def start do
    GenServer.start __MODULE__, []
  end

  # callbacks

  def init(_) do
    {:ok, []}
  end

  def handle_cast({:add, issue}, state) do
    {:noreply, [issue | state]}
  end

  def handle_call({:all}, _from, state) do
    {:reply, state, state}
  end

  # interfaces

  def add(pid, issue) do
    GenServer.cast pid, {:add, issue}
  end

  def all(ped) do
    GenServer.call ped, {:all}
  end
end
