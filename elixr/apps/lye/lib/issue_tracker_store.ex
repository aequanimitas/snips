defmodule Lye.IssueTrackerStore do
  alias Lye.ServerProcess

  def start do
    ServerProcess.start(__MODULE__)
  end

  def init do
    %{}
  end

  def handle_cast({:add, project, issue}, state) do
    Map.put(state, project, issue)
  end

  def handle_call({:get_issues, project}, state) do
    Map.get(state, project)
  end

  def add(pid, project, issue) do
    ServerProcess.cast pid, {:add, project, issue}
  end

  def get_issues(pid, project) do
    ServerProcess.call pid, {:get_issues, project}
  end
end
