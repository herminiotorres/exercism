defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    Regex.scan(~r/\(|\)|\{|\}|\[|\]/, str)
    |> List.flatten
    |> Enum.reduce("", fn char, acc ->
      cond do
        char == ")" and String.ends_with?(acc, "(") ->
          String.slice(acc, 0, String.length(acc)-1)

        char == "}" and String.ends_with?(acc, "{") ->
          String.slice(acc, 0, String.length(acc)-1)

        char == "]" and String.ends_with?(acc, "[") ->
          String.slice(acc, 0, String.length(acc)-1)

        true ->
          acc <> char
      end
    end) == ""
  end
end
