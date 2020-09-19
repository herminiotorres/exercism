defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    cond do
      score === 3       -> -4
      score in [4, 5]   -> -3
      score in [6, 7]   -> -2
      score in [8, 9]   -> -1
      score in [10, 11] -> 0
      score in [12, 13] -> 1
      score in [14, 15] -> 2
      score in [16, 17] -> 3
      score === 18      -> 4
    end
  end

  @spec ability :: pos_integer()
  def ability do
    Enum.random(3..18)
  end

  @spec character :: t()
  def character do
    character =
      %__MODULE__{
        strength: ability(),
        dexterity: ability(),
        constitution: ability(),
        intelligence: ability(),
        wisdom: ability(),
        charisma: ability()
      }
      
    %{character | hitpoints: 10 + modifier(character.constitution)}
  end
end
