defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size <= 0, do: []
  def slices(s, size) do
    slices(s, size, 0, String.length(s), []) |> Enum.reverse
  end

  defp slices(s, size, min, max, acc) when size+min <= max do
    slices(s, size, min+1, max, [String.slice(s, min, size) | acc])
  end
  defp slices(_, _, _, _, acc), do: acc
end
