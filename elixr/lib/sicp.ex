defmodule Elixr.Sicp do
  def sum_range(s, e) when e == 0, do: s
  def sum_range(s, e) when s > e, do: 0
  def sum_range(s, e) do
    s + sum_range(s + 1, e)
  end

  # exercise 1.31: Product as Higher-Order function
  def product_range(s, e) when s == 0 or e == 0, do: 0
  def product_range(s, e) when s > e, do: 1
  def product_range(s, e) do
    s * product_range(s + 1, e)
  end

  @doc """
  Exercise 1.32: “Show that sum and product (Exercise 1.31) 
  are both special cases of a still more general notion called 
  accumulate that combines a collection of terms, using some 
  general accumulation function:

  ```(accumulate combiner null-value term a next b)```

  Accumulate takes as arguments the same term and range 
  specifications as sum and product, together with a combiner 
  procedure (of two arguments) that specifies how the current 
  term is to be combined with the accumulation of the preceding 
  terms and a null-value that specifies what base value to use 
  when the terms run out. ”
  """
  def accumulate(combiner, nil_val, term, x, next, y) when x > y, do: nil_val

  def accumulate(combiner, nil_val, term, x, next, y) do
    combiner.(term.(x), accumulate(combiner, nil_val, term, next.(x), next, y))
  end

  # exercise 1.42: Compose
  def compose(fnx, fny) do
  end
end
