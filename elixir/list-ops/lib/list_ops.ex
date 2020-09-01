defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end
  defp count([], counter), do: counter
  defp count([_head | tail], counter), do: count(tail, counter + 1)

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end
  defp reverse([], list), do: list
  defp reverse([head | tail], list), do: reverse(tail, [head | list])

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map(l, f, [])
    |> reverse
  end
  defp map([], _f, list), do: list
  defp map([head | tail], f, list) do
    map(tail, f, [f.(head) | list])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
    |> reverse
  end
  defp filter([], _f, list), do: list
  defp filter([head | tail], f, list) do
    case f.(head) do
      true -> filter(tail, f, [head | list])
      _ -> filter(tail, f, list)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], 0, _f), do: 0
  def reduce([], acc, _f), do: acc
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    append(a, b, [])
  end
  defp append([], [], list), do: list |> reverse
  defp append(a, [], []), do: a
  defp append([a_head | a_tail], [], list) do
    append(a_tail, [], [a_head | list])
  end
  defp append([], b, []), do: b
  defp append([], [b_head | b_tail], list) do
    append([], b_tail, [b_head | list])
  end
  defp append([a_head | a_tail], [b_head | b_tail], list) do
    cond do
      a_head <= b_head -> append(a_tail, [b_head | b_tail], [a_head | list])
      a_head > b_head -> append([a_head | a_tail], b_tail, [b_head | list])
    end
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    concat(ll, [])
  end
  defp concat([head | tail], acc) when head == [], do: concat(tail, acc)
  defp concat([head | tail], acc) when is_list(head), do: concat(head, concat(tail, acc))
  defp concat([head | tail], acc), do: [head | concat(tail, acc)]
  defp concat([], acc), do: acc
end
