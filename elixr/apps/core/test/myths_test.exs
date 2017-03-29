defmodule Core.MythsTest do
  use ExUnit.Case, async: true

  alias Core.Myths

  test "pin operator" do
    y = 10
    assert_raise MatchError, fn ->
      ^y = 20
    end
  end

  test "naive reverse" do
    assert Myths.naive_reverse([]) == []
    assert Myths.naive_reverse([1,2]) == [2,1]
    assert 1..100 |> Enum.to_list |> Myths.naive_reverse ==
           1..100 |> Enum.to_list |> Enum.reverse
  end

  test "naive reverse but ok" do
    assert Myths.naive_reverse_but_ok([]) == []
    assert Myths.naive_reverse_but_ok([1,2]) == [2,1]
    assert 1..100 |> Enum.to_list |> Myths.naive_reverse_but_ok ==
           1..100 |> Enum.to_list |> Enum.reverse
  end

  test "vanilla reverse" do
    assert Myths.vanilla_reverse([]) == []
    assert Myths.vanilla_reverse([1,2]) == [2,1]
    assert Myths.vanilla_reverse(Enum.to_list(1..100)) ==
           1..100 |> Enum.to_list |> Enum.reverse
  end
end
