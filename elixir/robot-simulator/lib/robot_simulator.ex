defmodule RobotSimulator do
  defstruct direction: nil, position: nil

  @directions [:north, :east, :south, :west]
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ nil, position \\ nil) do
    try do
      robot =
        __struct__(
          direction: direction,
          position: position
        )

      cond do
        direction == nil and position == nil ->
          %__MODULE__{direction: :north, position: {0, 0}} |> Map.from_struct

        direction == direction(robot) and position == position(robot) ->
          robot |> Map.from_struct

        true ->
          raise "invalid position"
      end

    rescue
      MatchError -> {:error, "invalid position"}
      exception -> {:error, Exception.message(exception)}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    try do
      run(instructions, robot)
    rescue
      exception -> {:error, Exception.message(exception)}
    end
  end

  defp run("", robot), do: robot
  defp run("R" <> instructions, %{direction: :north} = robot) do
    run(instructions, %{robot | direction: :east})
  end
  defp run("L" <> instructions, %{direction: :north} = robot) do
    run(instructions, %{robot | direction: :west})
  end
  defp run("A" <> instructions, %{direction: :north, position: {x, y}} = robot) do
    run(instructions, %{robot | position: {x, y+1}})
  end
  defp run("R" <> instructions, %{direction: :east} = robot) do
    run(instructions, %{robot | direction: :south})
  end
  defp run("L" <> instructions, %{direction: :east} = robot) do
    run(instructions, %{robot | direction: :north})
  end
  defp run("A" <> instructions, %{direction: :east, position: {x, y}} = robot) do
    run(instructions, %{robot | position: {x+1, y}})
  end
  defp run("R" <> instructions, %{direction: :south} = robot) do
    run(instructions, %{robot | direction: :west})
  end
  defp run("L" <> instructions, %{direction: :south} = robot) do
    run(instructions, %{robot | direction: :east})
  end
  defp run("A" <> instructions, %{direction: :south, position: {x, y}} = robot) do
    run(instructions, %{robot | position: {x, y-1}})
  end
  defp run("R" <> instructions, %{direction: :west} = robot) do
    run(instructions, %{robot | direction: :north})
  end
  defp run("L" <> instructions, %{direction: :west} = robot) do
    run(instructions, %{robot | direction: :south})
  end
  defp run("A" <> instructions, %{direction: :west, position: {x, y}} = robot) do
    run(instructions, %{robot | position: {x-1, y}})
  end
  defp run(_, _), do: raise "invalid instruction"

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: direction} = _robot) do
    cond do
      direction in @directions
        -> direction

      true
        -> raise "invalid direction"
    end
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: {x, y}} = _robot) when is_integer(x) and is_integer(y) do
    {x, y}
  end
  def position(_robot), do: raise "invalid position"
end
