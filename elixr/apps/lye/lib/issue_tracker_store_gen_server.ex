defmodule Lye.IssueTrackerStoreGenServer do
  use GenServer

  def start do
    GenServer.start __MODULE__, []
  end

  def init(_) do
    :timer.send_interval(3000, :cleanup)
    {:ok, []}
  end

  def handle_cast({:add_project, project_name}, state) do
    project = %{"project_name" => project_name}
    {:noreply, [project | state]}
  end

  def handle_call({:get_projects}, _from, state) do
    projects = Enum.map(state, fn x -> x["project_name"] end)
    {:reply, projects, state}
  end

  def handle_info(:cleanup, state) do
    IO.puts "doing cleanup...."
    IO.puts inspect state
    {:noreply, state}
  end

  def handle_info(_, state) do
    {:noreply, state}
  end

  def add_project(pid, project_name) do
    GenServer.cast pid, {:add_project, project_name}
  end

  def get_projects(pid) do
    GenServer.call pid, {:get_projects}
  end
end
