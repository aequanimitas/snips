defmodule Sicp.RangeTest do
  use ExUnit.Case, async: true
  alias Sicp.Recursion.Range

  test "Sum" do
    result = Range.looper(1, 5, &(&1), &(&1), &Range.add/2)
    assert result == 15
  end

  test "Product" do
    result = Range.looper(1, 5, &(&1), &(&1 + 1), &Range.product/2)
    assert result == 120
  end
end
