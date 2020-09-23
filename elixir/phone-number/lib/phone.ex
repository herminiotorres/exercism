defmodule Phone do
  @digits ~w/2 3 4 5 6 7 8 9/

  defguard is_digits(country_code \\ "1", first_area_code, first_digit)
           when country_code == "1" and first_area_code in @digits and first_digit in @digits

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(
        <<"+", country_code::binary-size(1), " (", first_area_code::binary-size(1),
          area_code::binary-size(2), ") ", first_digit::binary-size(1),
          first_digits::binary-size(2), "-", last_digits::binary-size(4)>>
      )
      when is_digits(country_code, first_area_code, first_digit) do
    first_area_code <> area_code <> first_digit <> first_digits <> last_digits
  end

  def number(
        <<"(", first_area_code::binary-size(1), area_code::binary-size(2), ") ",
          first_digit::binary-size(1), first_digits::binary-size(2), "-",
          last_digits::binary-size(4)>>
      )
      when is_digits(first_area_code, first_digit) do
    first_area_code <> area_code <> first_digit <> first_digits <> last_digits
  end

  def number(
        <<first_area_code::binary-size(1), area_code::binary-size(2), ".",
          first_digit::binary-size(1), first_digits::binary-size(2), ".",
          last_digits::binary-size(4)>>
      )
      when is_digits(first_area_code, first_digit) do
    first_area_code <> area_code <> first_digit <> first_digits <> last_digits
  end

  def number(
        <<country_code::binary-size(1), first_area_code::binary-size(1),
          area_code::binary-size(2), first_digit::binary-size(1), first_digits::binary-size(2),
          last_digits::binary-size(4)>>
      )
      when is_digits(country_code, first_area_code, first_digit) do
    first_area_code <> area_code <> first_digit <> first_digits <> last_digits
  end

  def number(
        <<first_area_code::binary-size(1), area_code::binary-size(2), first_digit::binary-size(1),
          first_digits::binary-size(2), last_digits::binary-size(4)>>
      )
      when is_digits(first_area_code, first_digit) do
    first_area_code <> area_code <> first_digit <> first_digits <> last_digits
  end

  def number(_raw), do: "0000000000"

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    case number(raw) do
      "0000000000" -> "000"
      _area_code -> "212"
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    raw
    |> number
    |> format
  end

  defp format(
         <<first_area_code::binary-size(1), area_code::binary-size(2),
           first_digit::binary-size(1), first_digits::binary-size(2),
           last_digits::binary-size(4)>>
       ) do
    "(#{first_area_code}#{area_code}) #{first_digit}#{first_digits}-#{last_digits}"
  end

  defp format(_raw), do: "(000) 000-0000"
end
