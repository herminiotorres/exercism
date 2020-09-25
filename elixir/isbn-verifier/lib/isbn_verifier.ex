defmodule IsbnVerifier do
  @digits ~w/0 1 2 3 4 5 6 7 8 9/
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn
    |> String.replace("-", "")
    |> calc(10, 0)
    |> Kernel.rem(11)
    |> Kernel.==(0)
  end

  def calc("", _factor, sum), do: sum
  def calc("X", factor, sum), do: calc("", factor, 10 + sum)
  def calc(<<dig::binary-size(1), digs::binary>>, factor, sum) when dig in @digits do
    calc(digs, factor-1, String.to_integer(dig) * factor + sum)
  end
  def calc(<<_dig::binary-size(1), digs::binary>>, factor, sum), do: calc(digs, factor-1, sum)
end
