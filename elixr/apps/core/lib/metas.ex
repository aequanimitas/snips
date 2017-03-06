defmodule Elixr.Core.Metas do
  alias IO.ANSI

  @color_reset "\e[39m"

  @colors [
    "green": ANSI.color(2)
  ]

  for {name, code} <- @colors do
    def unquote(:"#{name}")(str) do
      [unquote(code), str, @color_reset]
    end
  end
end
