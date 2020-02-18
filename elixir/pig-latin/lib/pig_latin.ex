defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    cond do
      Regex.match?(~r/^(a|e|i|o|u|yt|xr)/, phrase) ->
        end_with(phrase)
      not Regex.match?(~r/^(a|e|i|o|u|yt|xr)/, phrase) ->
        phrase
        |> String.splitter("", trim: true)
        |> Enum.to_list
        |> reverse
        |> List.to_string
        |> end_with
      true -> phrase
    end
  end

  defp reverse([head | tail]), do: tail ++ head

  defp end_with(phrase), do: phrase <> "ay"
end
