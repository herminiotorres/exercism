defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.split(~r/[[:punct:][:blank:]]/, trim: true)
    |> Enum.join
    |> String.codepoints
    |> Enum.frequencies
    |> Enum.all?(fn {_k, v} -> v == 1 end)
  end
end
