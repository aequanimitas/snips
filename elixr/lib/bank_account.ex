defmodule Elixr.BankAccount do
  def start do
    # event sourcing: tracking events
    # start await with an empty list of events
    await([])
  end
  
  def await(events) do
    # handle the message here
    receive do
      {:check_balance, pid} ->
        # send this message back to sender (pid)
        divulge_balance pid, events
      {:deposit, amount} ->
        events = deposit(amount, events)
      {:withdraw, amount} ->
        events = withdraw(amount, events)
    end
    await events
  end

  defp withdraw(amount, events) do
    # handle the events here
    events ++ [{:withdrawal, amount}]
  end

  defp deposit(amount, events) do
    # handle the events here
    events ++ [{:deposit, amount}]
  end

  defp divulge_balance(pid, events) do
    # send this message back to sender (pid)
    send pid, {:balance, calculate_balance events}
  end

  defp calculate_balance(events) do
    deposits = events |> just_deposits |> sum
    withdrawals = events |> just_withdrawals |> sum
    deposits - withdrawals
  end

  defp just_deposits(events) do
    just_type(events, :deposit)
  end

  defp just_withdrawals(events) do
    just_type(events, :withdrawal)
  end

  defp just_type(events, expected_type) do
    Enum.filter(events, fn({type, _}) -> type == expected_type end)
  end

  defp sum(events) do
    Enum.reduce(events, 0, fn({_, amount}, acc) -> acc + amount end)
  end
end
