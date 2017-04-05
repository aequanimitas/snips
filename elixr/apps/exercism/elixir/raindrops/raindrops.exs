defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    if (number < 3) do
      Integer.to_string(number, 10)
    else
      convert(number, {3, "Pling"})
    end
  end

  @doc """
  If remainder between num and divisor is 0, append message, increase divisor
  """
  #@spec convert(num, {divisor, message}) :: String.t
  defp convert(num, {divisor, message}) do
    if divisor < 8 do
    else
    end
  end
end
