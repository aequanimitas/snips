defmodule Identicon do

  # helper function to accept input
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  # move the pattern matching to the argument.
  # - match the pattern in LHS
  # - assign labels to the first three elements, 
  # - RHS has to match the structure of the LHS
  def pick_color(%Identicon.Image{hex: [r,g,b | _tail]} = image) do
    # create a new record that contains the hex and image data
    # color has "meaning" for us, so the model used here is a tuple
    # the "image" here is labelled as "hex" inside the structure
    # I think this depends on order the properties were declared on the Image struct module
    %Identicon.Image{image | color: {r,g,b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end
end
