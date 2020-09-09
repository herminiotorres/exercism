defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r/[\-[:blank:]]/)
    |> Enum.map_join(&letters/1)
    |> String.upcase
  end

  defp letters(word) do
    characters =
      Regex.scan(~r/[[:upper:]]/, word)
      |> Enum.map_join(&List.flatten/1)

    cond do
      characters != word and characters != "" ->
        characters

      true ->
        word |> String.first
    end
  end
end
