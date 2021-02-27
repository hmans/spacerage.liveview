defmodule SpaceRageWeb.SectorLive do
  use SpaceRageWeb, :live_view

  alias Phoenix.PubSub
  alias SpaceRage.{Player, SectorServer}
  alias Momentum.{Vector3}

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      # Subscribe to PubSub events for this sector
      PubSub.subscribe(
        SpaceRage.PubSub,
        "sector:1"
      )

      socket = assign(socket, player_id: UUID.uuid4())
      socket = assign(socket, players: SectorServer.get_players(1))

      # Notify pubsub about the arrival of this player
      PubSub.broadcast(
        SpaceRage.PubSub,
        "sector:1",
        {:new_player,
         %Player{
           id: socket.assigns.player_id,
           position: Vector3.random() |> Vector3.scale(50)
         }}
      )
    end

    {:ok, socket,
     temporary_assigns: [
       players: []
     ]}
  end

  @impl true
  def handle_info({:new_player, _player}, socket) do
    socket = assign(socket, players: SectorServer.get_players(1))
    {:noreply, socket}
  end
end
