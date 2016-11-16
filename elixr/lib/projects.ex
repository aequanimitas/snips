defmodule Pascal do
  def edge?(x, y), do: edge?(x) or edge?(y)
  defp edge?(x), do: x == 1

  def within_bounds?(x, y), do: within_bounds?(x) or within_bounds?(y)
  defp within_bounds?(x), do: x > 0

end

ExUnit.start

defmodule PascalTest do
  use ExUnit.Case

  test "Edge" do
    assert Pascal.edge?(1, 1) == true
    assert Pascal.edge?(12, 1) == true
    assert Pascal.edge?(1, 12) == true
    assert Pascal.edge?(2, 12) == false
  end

  test "Bounds" do
    assert Pascal.within_bounds?(1, 1) == true
    assert Pascal.within_bounds?(-1, 1) == true
  end
end
