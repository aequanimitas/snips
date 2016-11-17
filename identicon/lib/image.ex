defmodule Identicon.Image do
  @moduledoc """
    Struct

  ## Examples
    
    iex> %Identicon.Image {}
    %Identicon.Image{hex: nil}
    iex> %Identicon.Image {hex: []}
    %Identicon.Image{hex: []}
  """
  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end
