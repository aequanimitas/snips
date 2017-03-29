defmodule Core.PatternMatchingTest do
  use ExUnit.Case
  doctest Core.PatternMatching

  alias Core.PatternMatching, as: PT

  test "match the first two elements of a list, elixirconf" do
    assert_raise MatchError, fn ->
      [a,a] = [2, 1, 0, 9]
    end
  end

  test "anagram" do
    assert PT.anagram("cat") == PT.anagram("tac")
    assert PT.anagram("cat") == PT.anagram("act")
    assert PT.anagram("cat") == PT.anagram("tca")
    assert PT.anagram("break") == PT.anagram("baker")
    assert PT.anagram("nameless") == PT.anagram("salesmen")
  end

  test "destructuring a struct" do
    assert is_map(PT.struct_pattern(%{a: 1, b: 2}))
  end
end
