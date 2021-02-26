defmodule SpaceRage.SectorServer do
  use GenServer

  def start_link(sector_id),
    do: GenServer.start_link(__MODULE__, sector_id, name: :"sector:#{sector_id}")

  def init(_sector_id) do
    {:ok, nil}
  end
end
