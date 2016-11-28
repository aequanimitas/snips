defmodule Elixr.NoobPatternMatchingTest do
  use ExUnit.Case, async: true
  test "unpack / destructure" do
    # constants
    [a, b] = [10, 20]
    assert 10 == a
    assert 20 == b
  end

  test "Matching errors" do
    assert_raise MatchError, fn -> 
      [a,1,c] = [1,2,3]
    end
  end

  test "Variables bind once (per match)" do
    assert_raise MatchError, fn -> 
      [a, a] = [1,2]
    end
  end

  test "Pin operator" do
    assert_raise MatchError, fn -> 
      a = 10
      [^a, b] = [1,2]
    end
  end

  test "Variables can be re-binded on the next expression" do
    a = 10
    a = 20
    assert a == 20
  end

  test "Opening a file that doesn't exist" do
    # eRROR no entRY
    assert {:error, :enoent} = File.read('lol.txt')
  end
end
