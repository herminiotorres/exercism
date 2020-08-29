defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{bottle(number, true)} of beer on the wall, #{bottle(number, false)} of beer.
    #{take_and_pass(number)}, #{number |> decrement |> bottle(false)} of beer on the wall.
    """
  end

  defp take_and_pass(number) do
    cond do
      number > 1  -> "Take one down and pass it around"
      number == 1 -> "Take it down and pass it around"
      true        -> "Go to the store and buy some more"
    end
  end

  defp decrement(number), do: number - 1

  defp bottle(0, true = _beginning_phrase), do: "No more bottles"
  defp bottle(0, false = _beginning_phrase), do: "no more bottles"
  defp bottle(number, _beginning_phrase) do
    cond do
      number > 1  -> "#{number} bottles"
      number == 1 -> "1 bottle"
      true        -> "99 bottles"
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(), do: lyrics(99..0)
  def lyrics(range) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
