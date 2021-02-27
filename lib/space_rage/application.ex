defmodule SpaceRage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SpaceRage.Repo,
      # Start the Telemetry supervisor
      SpaceRageWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SpaceRage.PubSub},
      # Start the Endpoint (http/https)
      SpaceRageWeb.Endpoint,
      # Start a worker by calling: SpaceRage.Worker.start_link(arg)
      # {SpaceRage.Worker, arg}
      {Registry, keys: :unique, name: SectorRegistry},
      {SpaceRage.SectorServer, 1}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SpaceRage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SpaceRageWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
