defmodule Core.Myths do
  @moduledoc """
  From http://erlang.org/doc/efficiency_guide/myths.html#id60476
  """
  def naive_reverse([h|t]), do: naive_reverse(t) ++ [h]
  def naive_reverse([]), do: []

  def naive_reverse_but_ok(lst), do: naive_reverse_but_ok(lst, [])
  defp naive_reverse_but_ok([h|t], acc), do: naive_reverse_but_ok(t, [h] ++ acc)
  defp naive_reverse_but_ok([], acc), do: acc

  def vanilla_reverse(lst), do: vanilla_reverse(lst, [])
  defp vanilla_reverse([h|t], acc), do: vanilla_reverse(t, [h | acc])
  defp vanilla_reverse([], acc), do: acc
end
