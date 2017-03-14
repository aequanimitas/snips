defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> Enum.reduce("", fn(ch, acc) -> acc <> rotate(ch, shift, 0) end)
  end

  defmacro special_char(number) do
    quote do: unquote(number) >= 32 and unquote(number) <= 58 == true
  end

  defmacro is_upcase(number), do: quote do: unquote(number) == 90

  defmacro is_downcase(number), do: quote do: unquote(number) == 122

  @doc """ 
  Handle punctuations, numbers and space 
  """
  def rotate(code, shift, counter) when special_char(code), do: <<code>>

  def rotate(code, shift, counter) when shift == 26 or shift == 0, do: <<code + counter>>

  @doc """
  Handle uppercase
  """
  def rotate(code, shift, counter) when is_upcase(code + counter), do: rotate(65, shift - 1, 0)

  @doc """
  Handle lowercase
  """
  def rotate(code, shift, counter) when is_downcase(code + counter), do: rotate(97, shift - 1, 0)

  @doc """
  Rotates a character by passing it's char code

  Example:
  iex> RotationalCipher.rotate(97, 13, 0)
  "n"
  """
  @spec rotate(code :: integer, shift :: integer, counter :: integer) :: String.t()
  def rotate(code, shift, counter), do: rotate(code, shift - 1, counter + 1)
end
