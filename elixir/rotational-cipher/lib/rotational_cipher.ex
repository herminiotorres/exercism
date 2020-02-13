defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @alphabet String.codepoints("abcdefghijklmnopqrstuvwxyz")

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    # IO.puts parser(text)
  end
end


# String.match?("josé", ~r/^[[:lower:]]+$/u)
