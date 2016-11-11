# Runtime of insertion sort
IO.puts div(trunc(2.0e14), trunc(1.0e10)) / :math.pow(60, 2)

defmodule Sort do
  def ins(lst) do
    [1,2,3]
  end
end

defmodule Runtime do
  def onetwotwo(x) do
    8 * :math.pow(x, 2) < 64 * x * :math.log2(x)
  end

  def onetwothree(x) do
    100 * :math.pow(x,2) < :math.pow(2, x)
  end
end

ExUnit.start

defmodule SortTest do
  use ExUnit.Case, async: true

  test "1.2-2" do
    assert Runtime.onetwotwo(43) == true
  end

  test "1.2-3" do
    # limit
    assert Runtime.onetwothree(1000) == true
  end
end
