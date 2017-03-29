defmodule Sicp.Recursion.Range do
  @moduledoc """
  SICP exercises using Elixir
  """

  def add(x, y) do
    x + y
  end

  def product(x, y) do
    x * y
  end

  def looper(x, y, term, next, operation) when x == y do
    x
  end

  def looper(x, y, term, next, operation) do
    operation.(term.(x), looper(next.(x), y, term, next, operation))
  end
end
