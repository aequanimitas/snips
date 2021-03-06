defmodule Udemy.Identicon do
  @moduledoc false

  # helper function to accept input
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  # move the pattern matching to the argument.
  # - match the pattern in LHS
  # - assign labels to the first three elements,
  # - RHS has to match the structure of the LHS
  def pick_color(%Udemy.Identicon.Image{hex: [r,g,b | _tail]} = image) do
  # create a new record that contains the hex and image data
  # color has "meaning" for us, so the model used here is a tuple
  # the "image" here is labelled as "hex" inside the structure
  # I think this depends on order the properties were declared on the Image
  # struct module

    %Udemy.Identicon.Image{image | color: {r,g,b}}
  end

  def save_image(image, filename) do
    File.write("#{filename}.png", image)
  end

  def draw_image(%Udemy.Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def build_pixel_map(%Udemy.Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, idx}) ->
      horizontal = rem(idx, 5) * 50
      vertical = div(idx, 5) * 50
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}
      {top_left, bottom_right}
    end

    %Udemy.Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Udemy.Identicon.Image{grid: grid} = image) do
     grid = Enum.filter grid, fn {code, _index} ->
       rem(code, 2) == 0
     end
     %Udemy.Identicon.Image{image | grid: grid}
  end

  def build_grid(%Udemy.Identicon.Image{hex: hex} = image) do
    grid = hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Udemy.Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def hash_input(input) do
    hex = :md5 |> :crypto.hash(input) |> :binary.bin_to_list
    %Udemy.Identicon.Image{hex: hex}
  end
end
