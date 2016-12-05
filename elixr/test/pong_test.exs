defmodule Elixr.PongTest do
  use ExUnit.Case

  test "It responds to a ping with a pong" do
    pong = spawn_link Elixr.Pong, :start, []
    # send to mailbox of process (pong)
    # with the message :pong along with a PID
    send pong, {:ping, self}
    assert_receive {:pong, pong}
  end

  test "multiple pings and pongs" do
    pong = spawn_link Elixr.Pong, :start, []
    send pong, {:ping, self}
    assert_receive {:pong, pong}
    send pong, {:ping, self}
    assert_receive {:pong, pong}
  end
end
