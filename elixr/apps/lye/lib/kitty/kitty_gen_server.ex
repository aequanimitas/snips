defmodule Lye.Kitty.KittyGenServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def order_cat(pid, name, color, description) do
    GenServer.call(pid, {:order, name, color, description})
  end

  def return_cat(pid, cat) do
    GenServer.cast(pid, {:return, cat})
  end

  def close_shop(pid) do
    GenServer.call(pid, :terminate)
  end

  # server
  def init([]), do: {:ok, []}

  def handle_call({:order, name, color, description}, _from, cats) do
    case Enum.empty?(cats) do
      true ->
        {:reply, make_cat(name, color, description), cats}
      _ ->
        {:reply, hd(cats), tl(cats)}
    end
  end

  def handle_call(:terminate, _from, cats) do
    {:stop, :normal, :ok, cats}
  end

  def handle_cast({:return, cat}, cats) do
    {:noreply, [cat | cats]}
  end

  def handle_info(msg, cats) do
    IO.puts "Unexpected message: #{msg}"
    {:noreply, cats}
  end

  def terminate(:normal, cats) do
    for c <- cats, do: IO.puts("#{c.name} was set free")
    :ok
  end

  def code_change(_old, state, _extra) do
    {:ok, state}
  end

  defp make_cat(name, color, description) do
    %{:name => name, :color => color, :description => description}
  end
end
