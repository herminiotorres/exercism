defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    integer_to_binary(code)
    |> handshake
    |> Enum.each
  end

  defp integer_to_binary(number) do
     Integer.digits(number, 2) |> Enum.join |> String.to_integer
  end


  defp handshake(binary) do
    cond do
      binary > 1000 ->
        handshake(binary - 10000)
      binary >= 1000 and binary < 10000 ->
        "jump"
      binary >= 100 and binary < 1000 ->
        "close your eyes"
      binary >= 10 and binary < 100 ->
        "double blink"
      binary >= 1 and binary < 10 ->
        "wink"
      true -> :ok
    end
  end
end
