defmodule Sicp.RangeTest do
  use ExUnit.Case, async: true
  alias Sicp.Recursion.Range

  test "Sum" do
    assert Range.looper(1, 5, fn x -> x end, fn x -> x + 1 end, &Range.add/2) == 15
  end

  test "Product" do
    assert Range.looper(1, 5, fn x -> x end, fn x -> x + 1 end, &Range.product/2) == 120
  end
end
