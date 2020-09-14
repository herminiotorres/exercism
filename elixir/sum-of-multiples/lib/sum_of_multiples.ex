defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    for num <- 1..limit, factor <- factors, num != limit and rem(num, factor) == 0 do
      num
    end
    |> Enum.uniq
    |> Enum.sum
  end
end
