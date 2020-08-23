defmodule Services.Repo do
  use Ecto.Repo,
    otp_app: :services,
    adapter: Ecto.Adapters.Postgres
end
