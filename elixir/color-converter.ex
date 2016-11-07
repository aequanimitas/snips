defmodule ColorConverter do
  def rgba(hex) do
    Base.decode16(hex) |> elem(1) |> :binary.decode_unsigned
  end
end

ExUnit.start

defmodule ColorConverterTest do
  use ExUnit.Case, async: true
  test "Converting pair hex value" do
    assert ColorConverter.rgba("FF") == 255
  end
end
