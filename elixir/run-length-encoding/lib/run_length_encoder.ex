defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.codepoints
    |> encode(1, "")
  end

  defp encode([], _, acc), do: acc
  defp encode([char | rest], count, acc) do
    cond do
      List.first(rest) == char ->
        encode(rest, count+1, acc)

      List.first(rest) != char and count > 1 ->
        encode(rest, 1, acc <> "#{count}#{char}")

      true ->
        encode(rest, 1, acc <> char)
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.codepoints
    |> decode("", "")
  end

  defp decode([], _count, acc), do: acc
  defp decode([char | rest], count, acc) do
    cond do
      char in ~w(1 2 3 4 5 6 7 8 9) ->
        decode(rest, count <> char, acc)

      count == "" ->
        decode(rest, count, acc <> char)

      true ->
        count = String.to_integer(count)
        decode(rest, "", acc <> String.duplicate(char, count))
    end
  end
end
