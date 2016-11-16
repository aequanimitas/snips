defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  def pick_color(image) do
    # hex_list is "undefined", acts as a label for image.hex
    # catch remaining elements by using pipe and underscore
    %Identicon.Image{hex: [r,g,b | _tail]} = image

    [r,g,b]
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end
end
