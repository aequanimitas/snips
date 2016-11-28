defmodule Types do
  use ExUnit.Case, async: true

  test "Numbers" do
    #assert_raise SyntaxError, fn -> x = .0000000000000000000000000000023432432432432234232324 end
    # 64-bit IEEE 754-1985 'double-precision' representation
    assert 0.0000000000000000012780816729618276896 == 0.00000000000000000127808167296182768961239867679641
  end

  test "Aliases and atoms" do
    assert ThisIsAnAtom == Elixr.ThisIsAnAtom, "Comparing atoms and aliases"
    assert :Lol != Elixr.Lol
    # will this clash?
    assert Lol == Elixr.Lol
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
    assert Elixr.ListFun.flatten([3]) == [3]
    assert Elixr.ListFun.flatten([[3]]) == [3]
    assert Elixr.ListFun.flatten([[[3]]]) == [3]
    assert Elixr.ListFun.flatten([[3], 3]) == [3, 3]
    assert Elixr.ListFun.flatten([[3], [[4]]]) == [3, 4]
    assert Elixr.ListFun.flatten([[3], [[4]], [[2] | [[[3]]]]]) == [3, 4, 3, 2]
    assert Elixr.ListFun.len([1,2,3,4]) == 4
    assert is_tuple(hd(Elixr.ListFun.zip([1,2,3,4]))) == true
    assert is_list(Elixr.ListFun.zip([1,2,3,4])) == true
  end

  test "Binaries" do
    assert '😀' == [128512]
    # how do you test the zero-width joiner?    
  end
end
