defmodule RangeTest do
  use ExUnit.Case, async: true

  test "Sum" do
    assert Elixr.Range.looper(1, 5, fn x -> x end, fn x -> x + 1 end, &Elixr.Range.add/2) == 15
  end

  test "Product" do
    assert Elixr.Range.looper(1, 5, fn x -> x end, fn x -> x + 1 end, &Elixr.Range.product/2) == 120
  end
end
