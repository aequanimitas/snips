defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nuc) when length(strand) == 0, do: 0
  def count(strand, nuc), do: count(strand, nuc, 0)

  @spec count([], char, non_neg_integer) :: non_neg_integer
  defp count([], nuc, ct), do: ct
  defp count([h | t], nuc, ct) when h == nuc, do: count(t, nuc, ct + 1)
  defp count([h | t], nuc, ct), do: count(t, nuc, ct)

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    histogram(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0})
  end

  defp histogram([], map), do: map

  defp histogram([head | tail], map) do
    histogram(tail, %{map | head => map[head] + 1}) 
  end
end
