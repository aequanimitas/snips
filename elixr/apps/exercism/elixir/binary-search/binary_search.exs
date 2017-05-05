defmodule BinarySearch do
  require Logger
  require Integer
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    lst = Tuple.to_list(numbers)
    search(lst, key, 0)
  end

  def search(numbers, key, index) do
    len = length(numbers)
    idx = div(len, 2)
    case length(numbers) do
      0 -> :not_found
      1 -> if key == hd(numbers), do: {:ok, index + idx}, else: :not_found 
      _ ->
        {left, right} = Enum.split(numbers, idx)
        h_left = left |> Enum.reverse |> hd
        h_right = hd(right)
        cond do
          key == h_right -> {:ok, idx + index}
          key > h_left -> search(right, key, index + idx)
          key == h_left -> 
            idx = case Integer.is_even(idx) do
                    true -> index + idx - 1
                    false -> index + idx
                 end
            {:ok, idx}
          key < h_left -> search(left, key, index - 1)
          true -> :not_found
        end
    end
  end
end
