defmodule WordCount do
  @pattern ~r{[!,:&@$%^&_" "]}

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> split
    |> counter
  end

  defp split(sentence) do
    sentence
    |> String.split(@pattern, trim: true)
  end

  defp counter(sentence) do
    sentence
    |> Enum.frequencies_by(&String.downcase/1)
  end
end
