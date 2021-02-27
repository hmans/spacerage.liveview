defmodule SpaceRageWeb.SectorLive do
  use SpaceRageWeb, :live_view

  alias Phoenix.PubSub
  alias SpaceRage.Player

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      # Subscribe to PubSub events for this sector
      PubSub.subscribe(
        SpaceRage.PubSub,
        "sector:1"
      )

      socket = assign(socket, player_id: UUID.uuid4())

      # Notify pubsub about the arrival of this player
      PubSub.broadcast(
        SpaceRage.PubSub,
        "sector:1",
        {:new_player, %Player{id: socket.assigns.player_id}}
      )
    end

    {:ok, socket}
  end

  @impl true
  def handle_info({:new_player, _player}, socket) do
    {:noreply, socket}
  end
end
