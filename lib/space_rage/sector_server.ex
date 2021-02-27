defmodule SpaceRage.SectorServer do
  use GenServer

  alias SpaceRage.Sector

  def start_link(sector_id),
    do: GenServer.start_link(__MODULE__, sector_id, name: name(sector_id))

  def get_players(sector_id),
    do: GenServer.call(name(sector_id), :get_players)

  def name(sector_id), do: String.to_atom("sector:#{sector_id}")

  @impl true
  def init(sector_id) do
    # Create state
    state = %Sector{id: sector_id}

    # Subscribe this process to pubsub
    Phoenix.PubSub.subscribe(SpaceRage.PubSub, "sector:1")

    {:ok, state}
  end

  @impl true
  def handle_info({:new_player, player}, state) do
    log("Adding new player " <> player.id)
    {:noreply, %{state | players: [player | state.players]}}
  end

  @impl true
  def handle_call(:get_players, _, state) do
    {:reply, state.players, state}
  end

  defp log(text) do
    IO.puts("[SectorServer] " <> text)
  end
end
