defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new, do: %{data: nil, next: nil}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    # Your implementation here...
    if empty?(list) do
      # confusing part, create an empty one to attach to? test passes
      %{list | data: elem, next: new()}
    else
      %{push(new(), elem) | next: list}
    end
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    # Your implementation here...
    length(list, 0)
  end

  @spec length(t, integer) :: non_neg_integer()
  defp length(list, counter) do
    # if initial condition passed, return immediately
    if is_nil(list) or empty?(list) do
      counter
    else
      length(list.next, counter + 1)
    end
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    # Your implementation here...
    list.data == nil and list.next == nil
  end

  @doc """
  Get the value of a head of the LinkedList. First node of a LinkedList. LIFO
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    # Your implementation here...
    if empty?(list) do
      {:error, :empty_list}
    else
      {:ok, list.data}
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    # Your implementation here...
    if is_nil(list.next) ->
      {:error, :empty_list}
    else
      {:ok, list.next}
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    # Your implementation here...
    if is_nil(list.data) do
      {:error, :empty_list}
    else
      {:ok, list.data, list.next}
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  This works even without guards, check length code
  """
  @spec from_list(list()) :: t
  def from_list(list) when Kernel.length(list) == 0, do: new()
  def from_list(list), do: from_list(new(), Enum.reverse(list))

  @spec from_list(t, [any() | list()]) :: t
  def from_list(list, [head|[]]), do: push(list, head)
  def from_list(list, [head|tail]), do: from_list(push(list, head), tail)

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: to_list(list, [])

  @spec to_list(t, list()) :: t
  def to_list(list, acc) do
    case pop(list) do
      {:error, _} -> Enum.reverse(acc)
      {:ok, data, lst} -> to_list(lst, [data | acc])
    end
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    # Your implementation here...
    reverse(list, new())
  end

  @spec reverse(t, t) :: t
  def reverse(list, acc) do
    case pop(list) do
      {:error, _} -> acc
      {:ok, data, lst} -> reverse(lst, push(acc, data))
    end
  end
end
