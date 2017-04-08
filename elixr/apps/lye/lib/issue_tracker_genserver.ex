defmodule Lye.IssueTrackerGenServer do
  use GenServer

  def start(_) do
    GenServer.start __MODULE__, nil
  end

end
