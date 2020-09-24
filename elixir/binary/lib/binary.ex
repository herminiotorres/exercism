defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    with true <- String.match?(string, ~r/^[0-1]+$/),
         number <- String.to_integer(string, 2) do
      number
    else
      _ -> 0
    end
  end
end
