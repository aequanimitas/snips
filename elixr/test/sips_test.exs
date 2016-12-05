defmodule Elixr.PingTest do
  use ExUnit.Case

  test "It responds to a pong with a ping" do
    ping = spawn_link Elixr.Ping, :start, []
    # send to mailbox of process (ping)
    # with the message :pong along with a PID
    send ping, {:pong, self}
    assert_receive {:ping, ping}
  end

  test "multiple pongs and pings" do
    ping = spawn_link Elixr.Ping, :start, []
    send ping, {:pong, self}
    assert_receive {:ping, ping}
    send ping, {:pong, self}
    assert_receive {:ping, ping}
  end
end
