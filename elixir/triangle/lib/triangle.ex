defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, a, a) when a <= 0, do: {:error, "all side lengths must be positive"}
  def kind(a, a, a), do: {:ok, :equilateral}

  def kind(a, b, a) when a+a <= b, do: {:error, "side lengths violate triangle inequality"}
  def kind(b, a, a) when a+a <= b, do: {:error, "side lengths violate triangle inequality"}
  def kind(a, a, b) when a+a <= b, do: {:error, "side lengths violate triangle inequality"}
  def kind(a, _b, a), do: {:ok, :isosceles}
  def kind(_b, a, a), do: {:ok, :isosceles}
  def kind(a, a, _b), do: {:ok, :isosceles}

  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0, do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) when a+b <= c, do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c) when a+c <= b, do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c) when b+c <= a, do: {:error, "side lengths violate triangle inequality"}
  def kind(_a, _b, _c), do: {:ok, :scalene}
end
