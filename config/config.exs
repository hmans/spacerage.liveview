# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :space_rage,
  ecto_repos: [SpaceRage.Repo]

# Configures the endpoint
config :space_rage, SpaceRageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qEXSP/D14XMyvlwHVcgzswGH95jikv2G7hLmEP/dLCwe37I1REomHLCX210o0CFx",
  render_errors: [view: SpaceRageWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SpaceRage.PubSub,
  live_view: [signing_salt: "tGuXL/2j"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
