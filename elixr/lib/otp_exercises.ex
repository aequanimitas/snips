defmodule Elixr.Otp.Exercises do
  @moduledoc false
end

defmodule Otp.Exercises.Two do
  @moduledoc false
end

defmodule Otp.Exercises.Two.One do
  @moduledoc false

  def sum([]), do: 0
  def sum([head | tail]) do
    head + sum(tail)
  end
end

defmodule Otp.Exercises.Two.Three do
  @moduledoc false

  @lst [1,[[2],3]]
  def with_pipe do
    @lst |> List.flatten |> Enum.reverse |> Enum.map(fn(x) -> x * x end)
  end

  def wo_pipe do
    Enum.map(Enum.reverse(List.flatten(@lst)), fn(x) -> x * x end)
  end
end

defmodule Otp.Exercises.Two.Four do
  @moduledoc false

  def translate(str) do
    :crypto.hash(:md5, str)
  end
end
