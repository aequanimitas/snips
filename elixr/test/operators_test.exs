defmodule Elixr.OperatorsTest do
  use ExUnit.Case, async: true

  test "pin operator" do
    y = 10
    assert_raise MatchError, fn ->
      ^y = 20
    end
  end
end
