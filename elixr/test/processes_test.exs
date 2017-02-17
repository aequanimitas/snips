defmodule Elixr.ProcessesTest do
  import ExUnit.CaptureIO

  use ExUnit.Case, async: true

  alias Elixr.Processes, as: Proc

  @moduledoc """
    Tests for understanding processes in elixir.
  """

  test "concurrency primitives - process spawning a function" do
    new_proc_pid = spawn(fn -> self() end)
    assert new_proc_pid != self()
  end

  test "concurrency primitives - sending message" do
    send self(), {:sent, "message"}
    assert_received {:sent, "message"}
  end

  test "concurrency primitives - receiving and sending back" do
    dolphin = spawn(Proc.Dolphin, :dolphin2, [])
    send dolphin, {self(), :fish}
    assert_received "So long and thanks for all the fish!"
  end
end
