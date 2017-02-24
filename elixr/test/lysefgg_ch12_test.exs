defmodule Elixr.Lysefgg.LinkmonTest do
  use ExUnit.Case, async: true

  alias Elixr.Lysefgg.Linkmon, as: Linkmon

  test "initializers" do
    pid = Linkmon.start_critic3()
    assert is_pid(pid)
  end
end
