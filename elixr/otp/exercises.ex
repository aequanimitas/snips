defmodule Exercises do
end

defmodule Exercises.Two do

end

defmodule Exercises.Two.One do
  def sum([]), do: 0
  def sum([head | tail]) do
    head + sum(tail)
  end
end

defmodule Exercises.Two.Three do
  @lst [1,[[2],3]]
  def with_pipe() do
    @lst |> List.flatten |> Enum.reverse |> Enum.map(fn(x) -> x * x end)
  end

  def wo_pipe() do
    Enum.map(Enum.reverse(List.flatten(@lst)), fn(x) -> x * x end)
  end
end
