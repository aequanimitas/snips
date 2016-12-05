defmodule Elixr.NoobPatternMatchingTest do
  use ExUnit.Case, async: true
  test "unpack / destructure" do
    # constants
    [a, b] = [10, 20]
    assert 10 == a
    assert 20 == b
  end

  test "Opening a file that doesn't exist" do
    # eRROR no entRY
    assert {:error, :enoent} = File.read('lol.txt')
  end
end
