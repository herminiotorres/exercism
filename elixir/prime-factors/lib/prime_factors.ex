defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    calc(number, 2, [])
  end

  defp calc(number, factor, acc) when number < factor, do: Enum.sort(acc)
  defp calc(number, factor, acc) when div(number, factor) >= 1 and rem(number, factor) == 0 do
    case acc |> Enum.filter(& rem(factor, &1) == 0 and &1 != factor) do
      [] -> calc(div(number, factor), factor, [factor | acc])
      _  -> calc(number, factor+1, acc)
    end
  end
  defp calc(number, factor, acc), do: calc(number, factor+1, acc)
end
