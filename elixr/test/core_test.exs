defmodule Elixr.Core.PatternMatchingTest do
  use ExUnit.Case, async: true

  test "match the first two elements of a list, elixirconf" do
    assert_raise MatchError, fn -> 
      [a,a] = [2, 1, 0, 9] 
    end
  end

  test "anagram" do
    assert anagram("cat") == anagram("tac")
    assert anagram("cat") == anagram("act")
    assert anagram("cat") == anagram("tca")
    assert anagram("break") == anagram("baker")
    assert anagram("nameless") == anagram("salesmen")
  end

  defp anagram(word) do
    word |> String.codepoints() |> Enum.sort()
  end
end
