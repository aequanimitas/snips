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
  def count(strand, nucleotide) do
    if Enum.empty?(strand) do
      0
    else
      count(strand, nucleotide, 0)
    end
  end

  @spec count([], char, non_neg_integer) :: non_neg_integer
  defp count([], nucleotide, counter) do
    counter 
  end

  defp count([head | tail], nucleotide, counter) do
    if head == nucleotide do
      count(tail, nucleotide, counter + 1)
    else
      count(tail, nucleotide, counter)
    end 
  end

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

  defp histogram([], map) do
    map
  end

  defp histogram([head | tail], map) do
    histogram(tail, %{map | head => map[head] + 1}) 
  end
end
