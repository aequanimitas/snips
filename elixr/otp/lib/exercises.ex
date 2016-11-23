defmodule Otp.Exercises do
end

defmodule Otp.Exercises.Two do

end

defmodule Otp.Exercises.Two.One do
  def sum([]), do: 0
  def sum([head | tail]) do
    head + sum(tail)
  end
end

defmodule Otp.Exercises.Two.Three do
  @lst [1,[[2],3]]
  def with_pipe() do
    @lst |> List.flatten |> Enum.reverse |> Enum.map(fn(x) -> x * x end)
  end

  def wo_pipe() do
    Enum.map(Enum.reverse(List.flatten(@lst)), fn(x) -> x * x end)
  end
end

defmodule Otp.Exercises.Two.Four do
  def translate(str) do
    :crypto.hash(:md5, str)
  end
end
