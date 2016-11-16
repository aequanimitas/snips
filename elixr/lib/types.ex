ExUnit.start

defmodule ListFun do

  @doc """
  Naive implementation of flatten. Returns a single-level array (I don't know the technical term for this

  ## Example
  
      iex> ListFun.flatten([[]])
      []
  """

  @spec flatten(list()) :: list()

  def flatten(lst) do
    flatten(lst, [])
  end

  defp flatten([], accu), do: Enum.reverse(accu)

  defp flatten([head|tail], accu) do
    if is_list(head) do
      flatten(tail, flatten(head) ++ accu)
    else
      flatten(tail, [head] ++ accu)
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
        
        iex> ListFun.zip([1,2,3], ["a", "b", "c"])
        [{1, "a"}, {2, "b"}, {3, "c"}]

        iex> ListFun.zip([1,2,3], ["a", "b"])
        [{1, "a"}, {2, "b"}, {3}]
  """
  def zip(lst) do
    [{}]
  end
end

defmodule Types do
  use ExUnit.Case, async: true

  test "Numbers" do
    #assert_raise SyntaxError, fn -> x = .0000000000000000000000000000023432432432432234232324 end
    # 64-bit IEEE 754-1985 'double-precision' representation
    assert 0.0000000000000000012780816729618276896 == 0.00000000000000000127808167296182768961239867679641
  end

  test "Aliases and atoms" do
    assert ThisIsAnAtom == Elixir.ThisIsAnAtom, "Comparing atoms and aliases"
    assert :Lol != Elixir.Lol
    # will this clash?
    assert Lol == Elixir.Lol
    # but still an atom
    assert is_atom Lol
    # booleans are also atoms with values either true or false
    assert is_atom false
    assert is_atom nil
    assert :true == true
    assert :false == false
    assert nil == :nil
  end

  test "Tuples" do
    assert elem({10, 20}, 1) == 20
    # throws if elem count on left doesn't match count on right
    assert_raise MatchError, fn -> 
      {name, age, gender} = {"BoB", 79}
    end
  end

  test "Lists" do
    # init list with a million elements
    a = Enum.map 1..1_000_000, fn b -> b end
    assert List.last(a) == 1_000_000
  end

  test "List / Enum exploration" do
    assert ListFun.flatten([3]) == [3]
    assert ListFun.flatten([[3]]) == [3]
    assert ListFun.flatten([[[3]]]) == [3]
    assert ListFun.flatten([[3], 3]) == [3, 3]
    assert ListFun.flatten([[3], [[4]]]) == [3, 4]
    assert ListFun.flatten([[3], [[4]], [[2] | [[[3]]]]]) == [3, 4, 3, 2]
    assert ListFun.len([1,2,3,4]) == 4
    assert is_tuple(hd(ListFun.zip([1,2,3,4]))) == true
    assert is_list(ListFun.zip([1,2,3,4])) == true
  end

  test "Binaries" do
    assert '😀' == [128512]
    # how do you test the zero-width joiner?    
  end
end
