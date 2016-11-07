ExUnit.start

defmodule Types do
  use ExUnit.Case, async: true

  test "Numbers" do
    assert_raise SyntaxError, fn -> x = .0000000000000000000000000000023432432432432234232324 end
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

  test "Lists" do
    # init list with a million elements
    a = Enum.map 1..1_000_000, fn b -> b end
    assert List.last(a) == 1_000_000
  end
end
