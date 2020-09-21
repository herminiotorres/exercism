defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    list
    |> flatten([])
    |> sort
  end

  defp sort(list) when is_list(list) do
    sorted = iterate(list)

    cond do
      sorted == list -> sorted
      true           -> sort(sorted)
    end
  end

  defp iterate([current, next | tail]) when current > next do
    [next | iterate([current | tail])]
  end
  defp iterate([current, next | tail]) do
    [current | iterate([next | tail])]
  end
  defp iterate(list), do: list


  defp flatten([], acc), do: acc
  defp flatten([head | tail], acc) when is_list(head) do
    flatten(head) ++ flatten(tail, acc)
  end
  defp flatten([head | tail], acc) when is_nil(head) do
    flatten(tail, acc)
  end
  defp flatten([head | tail], acc) do
    flatten(tail, [head | acc])
  end
end
