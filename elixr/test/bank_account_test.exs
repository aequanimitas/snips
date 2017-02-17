defmodule Elixr.BankAccountTest do
  use ExUnit.Case

  test "starting balance should be 0" do
    account = spawn_link Elixr.BankAccount, :start, []
    verify_balance_is 0, account
  end

  test "has balance incremented by the amount of deposit" do
    account = spawn_link Elixr.BankAccount, :start, []
    send account, {:deposit, 10}
    verify_balance_is 10, account
  end

  test "has balance decremented by the amount of withdrawal" do
    account = spawn_link Elixr.BankAccount, :start, []
    send account, {:deposit, 20}
    send account, {:withdraw, 10}
    verify_balance_is 10, account
    send account, {:deposit, 20}
    verify_balance_is 30, account
  end

  def verify_balance_is(expected_balance, account) do
    # send to mailbox of process (account)
    # with the message :check_balance along with a PID
    send account, {:check_balance, self}
    assert_receive {:balance, ^expected_balance}
  end

end
