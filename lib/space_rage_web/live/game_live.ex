defmodule SpaceRageWeb.GameLive do
  use SpaceRageWeb, :live_view

  alias Phoenix.PubSub

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      # Subscribe to PubSub events for this sector
      PubSub.subscribe(
        SpaceRage.PubSub,
        "sector:1"
      )

      # Notify pubsub about the arrival of this player
      PubSub.broadcast(SpaceRage.PubSub, "sector:1", {:new_player, SpaceRage.Player.new()})
    end

    {:ok, socket}
  end

  @impl true
  def handle_info({:new_player, player}, socket) do
    {:noreply, socket}
  end
end
