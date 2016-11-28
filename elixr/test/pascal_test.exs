defmodule Elixr.PascalTest do
  use ExUnit.Case

  test "Edge" do
    assert Elixr.Pascal.edge?(1, 1) == true
    assert Elixr.Pascal.edge?(12, 1) == true
    assert Elixr.Pascal.edge?(1, 12) == true
    assert Elixr.Pascal.edge?(2, 12) == false
  end

  test "Bounds" do
    assert Elixr.Pascal.within_bounds?(1, 1) == true
    assert Elixr.Pascal.within_bounds?(-1, 1) == true
  end
end
