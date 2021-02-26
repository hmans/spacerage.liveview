defmodule SpaceRage.SectorServer do
  use GenServer

  def start_link(_),
    do: GenServer.start_link(__MODULE__, nil)

  def init(_) do
    {:ok, nil}
  end
end
