defmodule Elixr.Operators do
  # I think I should not be concerned with this since I "trust" elixir
  # creators that they've handled this already, but knowing a bit more
  # about the implementation and techniques does not hurt.
  def naive_reverse([h|t]), do: naive_reverse(t) ++ [h]
  def naive_reverse([]), do: []

  def naive_reverse_but_ok(lst), do: naive_reverse_but_ok(lst, [])
  defp naive_reverse_but_ok([h|t], acc), do: naive_reverse_but_ok(t, [h] ++ acc)
  defp naive_reverse_but_ok([], acc), do: acc

  def vanilla_reverse(lst), do: vanilla_reverse(lst, [])
  defp vanilla_reverse([h|t], acc), do: vanilla_reverse(t, [h | acc])
  defp vanilla_reverse([], acc), do: acc
end
