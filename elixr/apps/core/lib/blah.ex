defmodule Core.PatternMatching do
  def struct_pattern(x = %{a: _a, b: _b}) do
    x
  end

  def anagram(word) do
    word |> String.codepoints() |> Enum.sort()
  end
end
