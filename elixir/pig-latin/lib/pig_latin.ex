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
    phrase |> String.split() |> translate([]) |> Enum.reverse() |> Enum.join(" ")
  end

  defp translate([], accumulator), do: accumulator
  defp translate([word], accumulator), do: translate([], [switch_letter(word) | accumulator])

  defp translate([word | phrase], accumulator) do
    translate(phrase, [switch_letter(word) | accumulator])
  end

  defp switch_letter(<<"ch", rest_word::binary>>), do: switch_letter("#{rest_word}ch")
  defp switch_letter(<<"qu", rest_word::binary>>), do: switch_letter("#{rest_word}qu")
  defp switch_letter(<<"squ", rest_word::binary>>), do: switch_letter("#{rest_word}squ")
  defp switch_letter(<<"th", rest_word::binary>>), do: switch_letter("#{rest_word}th")
  defp switch_letter(<<"thr", rest_word::binary>>), do: switch_letter("#{rest_word}thr")
  defp switch_letter(<<"sch", rest_word::binary>>), do: switch_letter("#{rest_word}sch")

  defp switch_letter(<<"x", second_letter::binary-size(1), rest_word::binary>>) do
    cond do
      !Enum.member?(["a", "e", "i", "o", "u"], second_letter) ->
        "x#{second_letter}#{rest_word}ay"

      true ->
        switch_letter("#{second_letter}#{rest_word}x")
    end
  end

  defp switch_letter(<<"y", second_letter::binary-size(1), rest_word::binary>>) do
    cond do
      !Enum.member?(["a", "e", "i", "o", "u"], second_letter) ->
        "y#{second_letter}#{rest_word}ay"

      true ->
        switch_letter("#{second_letter}#{rest_word}y")
    end
  end

  defp switch_letter(<<first_letter::binary-size(1), rest_word::binary>>) do
    cond do
      Enum.member?(["a", "e", "i", "o", "u"], first_letter) ->
        "#{first_letter}#{rest_word}ay"

      true ->
        switch_letter("#{rest_word}#{first_letter}")
    end
  end
end
