defmodule BinarySearch do
  require Logger
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
    idx = 0
    cond do
      length(lst) == 0 -> :not_found
      length(lst) == 1 -> 
        if hd(lst) == key do
          {:ok, idx}
        else
          :not_found
        end
      true -> search(lst, key, idx)
    end
  end

  def search(lst, key, index) do
    {lst, idx} = chunk(lst)
    if length(lst) == 1 do
      [[h]] = lst
      if key == h do
        {:ok, idx}
      else
        :not_found
      end
    else
      [l_side, r_side] = lst
      l_head = 
        l_side
        |> Enum.reverse
        |> hd
      r_head = hd(r_side)
      cond do
        key > r_head -> search(r_side, key, idx + index)
        key < l_head -> search(r_side, key, idx - index)
        true -> {:ok, idx - 1}
      end
    end
    # conditions to be met
    # if lst length is 1
    #   destructure lst as [[h]]
    #   if key is equal to h
    #     return {:ok, index}
    #   else
    #     return :not_found
    # else 
    #   destructure lst into l_side and r_side
    #   reverse l_side and get its head, assign to left
    #   get r_side head, assign to right
    #  
  end

  @doc """
  returns the chunks of the list along with length of the list in half
  the length of the half will either be:
  - added to the index tracker if its greater than the `left` side's last elem
  - or subtracted to the index tracker if its less than the `left` side's last elem
  """
  def chunk(lst) do
    len = length(lst)
    step = div(len, 2)
    case rem(len, 2) == 0 do
      true -> {Enum.chunk(lst, step, step, []), step}
      false -> {Enum.chunk(lst, step + 1, step + 1, []), step + 1}
    end
  end
end
