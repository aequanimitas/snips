defmodule Identicon.Image do
  @moduledoc """
    Struct

  ## Examples
    
    iex> %Identicon.Image {}
    %Identicon.Image{hex: nil}
    iex> %Identicon.Image {hex: []}
    %Identicon.Image{hex: []}
  """
  defstruct hex: nil
end
