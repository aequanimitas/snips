defmodule Elixr.Pascal do
  def edge?(x, y), do: edge?(x) or edge?(y)
  defp edge?(x), do: x == 1

  def within_bounds?(x, y), do: within_bounds?(x) or within_bounds?(y)
  defp within_bounds?(x), do: x > 0

end
