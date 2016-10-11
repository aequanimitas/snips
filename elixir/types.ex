ExUnit.start

defmodule Types do
  use ExUnit.Case, async: true

  test "Aliases and atoms" do
    assert ThisIsAnAtom == Elixir.ThisIsAnAtom
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
