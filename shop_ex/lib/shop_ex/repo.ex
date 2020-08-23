defmodule ShopEx.Repo do
  use Ecto.Repo,
    otp_app: :shop_ex,
    adapter: Ecto.Adapters.Postgres
end
