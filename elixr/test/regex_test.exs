defmodule Elixr.UnderstandingRegexTest do
  use ExUnit.Case, async: true

  test "lowercase" do
    assert "hta" =~ ~r/^[a-z]*$/
  end

  test "numbers, safe way, not matching unicode defined digits" do
    assert "12345678" =~ ~r/^[0-9]*$/
  end

  test "special characters" do
    assert "!" =~ ~r/^[!@#$%^&*().,_]*$/
  end
end
