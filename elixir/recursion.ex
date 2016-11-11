# try sicp exercises using elixir

defmodule Range do
  def add(x, y) do
    x + y
  end

  def product(x, y) do
    x * y
  end

  def looper(x, y, term, next, operation) when x == y do
    x
  end

  def looper(x, y, term, next, operation) do
    operation.(term.(x), looper(next.(x), y, term, next, operation))
  end
end

ExUnit.start

defmodule RangeTest do
  use ExUnit.Case, async: true

  test "Sum" do
    assert Range.looper(1, 5, fn x -> x end, fn x -> x + 1 end, &Range.add/2) == 15
  end

  test "Product" do
    assert Range.looper(1, 5, fn x -> x end, fn x -> x + 1 end, &Range.product/2) == 120
  end
end
