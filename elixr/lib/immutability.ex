ExUnit.start

defmodule Immutability do
  use ExUnit.Case, async: true
  test "Immutability understanding" do
    x = [1,2,3]

    # the list should not be mutatetd
    y = fn ->
      x ++ [1]
    end

    # the variable x should not be bound to a new value
    z = fn ->
      # try to bind inside anon fn
      x = 1
    end

    # pass by value, but thinking in a "let" like binding
    # "b" exists until control is given back to the calling function
    a = fn(b) ->
      b  = b ++ [3]
    end

    assert y.() != x
    assert z.() != x
    assert a.(x) != x

    # rebind here
    x = x ++ [1]
    assert [1,2,3,1] == x
  end
end
