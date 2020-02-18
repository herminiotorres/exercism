defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @first_alphabet_char_downcase 65
  @last_alphabet_char_downcase 90
  @first_alphabet_char_uppercase 97
  @last_alphabet_char_uppercase 122

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.graphemes
    |> Enum.map(fn char -> shifter_char(char, char, shift) end)
    |> IO.iodata_to_binary
  end

  defp shifter_char(<<char::utf8>>, _, shift) when char >= @first_alphabet_char_downcase and char <= @last_alphabet_char_downcase do
    next_char = char + shift
    char_to_string(next_char, @first_alphabet_char_downcase, @last_alphabet_char_downcase)
  end

  defp shifter_char(<<char::utf8>>, _, shift) when char >= @first_alphabet_char_uppercase and char <= @last_alphabet_char_uppercase do
    next_char = char + shift
    char_to_string(next_char, @first_alphabet_char_uppercase, @last_alphabet_char_uppercase)
  end

  defp shifter_char(_, char, _), do: char

  defp char_to_string(next_char, first_char, last_char) when next_char > last_char do
    List.to_string([(first_char - 1) + rem(next_char, last_char)])
  end

  defp char_to_string(next_char, _, _), do: List.to_string([next_char])
end
