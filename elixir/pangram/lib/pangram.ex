defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    (lower?(sentence) || punctuation?(sentence)) &&
      sentence_with_x_character?(sentence) &&
      word_with_numbers?(sentence)
  end

  def punctuation?(sentence) do
    sentence_in_list = String.split(sentence)

    first_sentence =
      sentence_in_list
      |> List.first
      |> String.match?(~r/^[[:upper:]]/)

    last_sentence =
      sentence_in_list
      |> List.last
      |> String.match?(~r/.$/)

    first_sentence && last_sentence
  end

  def lower?(sentence) do
    String.downcase(sentence) == sentence
  end

  def sentence_with_x_character?(sentence) do
    String.match?(sentence, ~r/x/)
  end

  def word_with_numbers?(sentence) do
    digits = 0..9 |> Enum.map(&Integer.to_string(&1))

    sentence
    |> String.split()
    |> Enum.all?(fn word ->
      word in digits || not String.contains?(word, digits)
    end)
  end
end
