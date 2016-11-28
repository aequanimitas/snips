ExUnit.start

defmodule Elixr.ListFun do

  @doc """
  Naive implementation of flatten. Returns a single-level array (I don't know the technical term for this)

  ## Examples
      iex> Elixr.ListFun.flatten([[]])
      []

  """

  @spec flatten(list()) :: list()

  def flatten(lst) do
    flatten(lst, [])
  end

  defp flatten([], accu), do: Enum.reverse(accu)

  defp flatten([head|tail], accu) do
    case is_list head do
      :true -> flatten(tail, flatten(head) ++ accu)
      :false -> flatten(tail, [head] ++ accu)
    end
  end

  @doc """
  Naive implementation for length
  """

  @spec len(list()) :: number()

  def len(lst) do
    len(lst, 0)
  end

  defp len([], accu), do: accu

  defp len([head|tail], accu) do
    len(tail, accu + 1)
  end

  @doc """
    Combine lists into ordered collection

    ## Examples
        
        iex> Elixr.ListFun.zip([1,2,3], ["a", "b", "c"])
        [{1, "a"}, {2, "b"}, {3, "c"}]

        iex> Elixr.ListFun.zip([1,2,3], ["a", "b"])
        [{1, "a"}, {2, "b"}, {3}]
  """
  def zip(lst) do
    [{}]
  end
end
