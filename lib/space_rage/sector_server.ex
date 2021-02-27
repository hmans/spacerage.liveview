defmodule SpaceRage.SectorServer do
  use GenServer

  def start_link(sector_id),
    do: GenServer.start_link(__MODULE__, sector_id, name: :"sector:#{sector_id}")

  @impl true
  def init(_sector_id) do
    # Subscribe this process to pubsub
    Phoenix.PubSub.subscribe(SpaceRage.PubSub, "sector:1")

    {:ok, nil}
  end

  @impl true
  def handle_info({:new_player}, state) do
    {:noreply, state}
  end
end
