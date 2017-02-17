defmodule Elixr.Recursion do
  def factorial(x) when x == 0 or x == 1, do: 1
  def factorial(x) do
    x * factorial(x - 1)
  end
end

defmodule Elixr.RecursionTest do
  use ExUnit.Case, async: true

  alias Elixr.Recursion

  test "factorial" do
    assert Recursion.factorial(0) == 1
    assert Recursion.factorial(1) == 1
    assert Recursion.factorial(2) == 2
    assert Recursion.factorial(3) == 6
    assert Recursion.factorial(4) == 24
    assert Recursion.factorial(5) == 120
  end
end
