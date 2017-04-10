defmodule Lye.IssueTracker.Server do
  use GenServer

  import Logger

  alias Lye.IssueTracker.Database

  def start {name, initial_state} do
    GenServer.start __MODULE__, {name, initial_state}, name: String.to_atom(name)
  end

  # callbacks

  def init({db_name, initial_state}) do
    Logger.debug db_name
    {:ok, {db_name, Database.get(db_name) || initial_state}}
  end

  def handle_cast({:add, issue}, {name, issues}) do
    issues = [issue | issues]
    Database.store(name, issues)
    {:noreply, {name, issues}}
  end

  # maintain the structure of the final argument, which is the state, in the
  # return value or else the code will turn nuts, this is a two-element tuple
  # that contains the db name and the list of issues
  def handle_call({:all}, _from, {name, issues}) do
    {:reply, issues, {name, issues}}
  end

  # interfaces

  def add(pid, issue) do
    GenServer.cast pid, {:add, issue}
  end

  def all(ped) do
    GenServer.call ped, {:all}
  end
end
