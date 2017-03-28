defmodule ColorConverter do
  @moduledoc false

  def rgba(hex) do
    hex |> Base.decode16 |> elem(1) |> :binary.decode_unsigned
    # SO alternative using shebang
    # hex |> Base.decode16! |> :binary.decode_unsigned
  end
end

ExUnit.start

defmodule ColorConverterTest do
  @moduledoc false

  use ExUnit.Case, async: true
  test "Converting pair hex value" do
    assert ColorConverter.rgba("FF") == 255
  end
end
