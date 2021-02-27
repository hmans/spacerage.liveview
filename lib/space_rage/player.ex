defmodule SpaceRage.Player do
  defstruct id: nil

  def new do
    %__MODULE__{id: UUID.uuid4()}
  end
end
