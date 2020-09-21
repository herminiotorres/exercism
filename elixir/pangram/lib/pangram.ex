defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @digits Enum.map(0..9, &Integer.to_string(&1))

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    lower_or_mixed_case_with_punctuation?(sentence) &&
    sentence_with_x_character?(sentence) &&
    word_with_numbers?(sentence)
  end

  defp lower_or_mixed_case_with_punctuation?(sentence) do
    String.match?(sentence, ~r/^[[:upper:]]{1}.|[[:lower:]]$/)
  end

  defp sentence_with_x_character?(sentence) do
    String.match?(sentence, ~r/x/)
  end

  defp word_with_numbers?(sentence) do
    sentence
    |> String.split()
    |> Enum.all?(fn word ->
      word in @digits || not String.contains?(word, @digits)
    end)
  end
end
