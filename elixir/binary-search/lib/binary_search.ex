defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found
  def search(numbers, key) do
    size = numbers |> Tuple.to_list() |> length
    search(numbers, key, 0, size-1)
  end

  defp search(numbers, key, pos, _size) when elem(numbers, pos) == key, do: {:ok, pos}
  defp search(_numbers, _key, pos, size) when pos == size, do: :not_found
  defp search(numbers, key, pos, size), do: search(numbers, key, pos+1, size)
end
