# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shop_ex,
  ecto_repos: [ShopEx.Repo]

# Configures the endpoint
config :shop_ex, ShopExWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kzQmUtLAV6QQNZNP7TQ+rTOtHwvumOOQkNIYsvBDducxzzz12R9LYHm4qGGrYwXQ",
  render_errors: [view: ShopExWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ShopEx.PubSub,
  live_view: [signing_salt: "wyH7iBfE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
