defmodule SpaceRage.Repo do
  use Ecto.Repo,
    otp_app: :space_rage,
    adapter: Ecto.Adapters.Postgres
end
