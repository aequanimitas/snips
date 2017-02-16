defmodule Elixr.OperatorsTest do
  use ExUnit.Case, async: true

  alias Elixr.Operators

  test "pin operator" do
    y = 10
    assert_raise MatchError, fn ->
      ^y = 20
    end
  end

  test "naive reverse" do
    assert Operators.naive_reverse([]) == []
    assert Operators.naive_reverse([1,2]) == [2,1]
    assert Operators.naive_reverse(Enum.to_list(1..100)) == 
           Enum.to_list(1..100) |> Enum.reverse
  end

  test "naive reverse but ok" do
    assert Operators.naive_reverse_but_ok([]) == []
    assert Operators.naive_reverse_but_ok([1,2]) == [2,1]
    assert Operators.naive_reverse_but_ok(Enum.to_list(1..100)) == 
           Enum.to_list(1..100) |> Enum.reverse
  end

  test "vanilla reverse" do
    assert Operators.vanilla_reverse([]) == []
    assert Operators.vanilla_reverse([1,2]) == [2,1]
    assert Operators.vanilla_reverse(Enum.to_list(1..100)) == 
           Enum.to_list(1..100) |> Enum.reverse
  end
end
