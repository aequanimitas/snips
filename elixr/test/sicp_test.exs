defmodule Elixr.SicpTest do
  use ExUnit.Case, async: true

  alias Elixr.Sicp

  test "sum range" do
    assert Sicp.sum_range(2, 0) == 2
    assert Sicp.sum_range(0, 2) == 3
    assert Sicp.sum_range(0, 0) == 0
    assert Sicp.sum_range(0, 10) == 55
  end

  test "1.31 - product as higher-order function" do
    assert Sicp.product_range(2, 0) == 0
    assert Sicp.product_range(0, 2) == 0
    assert Sicp.product_range(0, 0) == 0
    assert Sicp.product_range(1, 5) == 120
  end

  test "1.32 - accumulator: sum" do
    assert Sicp.accumulate(
      fn(x, y) -> x + y end, # combiner, basic sum
      0, # nil_val
      fn(x) -> x end, # identity
      1, # start count
      fn (x) -> x + 1 end, # increment
      5 # end count
    ) == 15
  end

  test "1.32 - accumulator: product" do
    assert Sicp.accumulate(
      fn(x, y) -> x * y end, # combiner, product
      1, # nil_val
      fn(x) -> x end, # identity
      1, # start count
      fn (x) -> x + 1 end, # increment
      5 # end count
    ) == 120
  end

  test "1.43 - compose" do
  end

end
