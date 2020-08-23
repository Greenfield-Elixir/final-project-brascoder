defmodule Services.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    :logger.add_primary_filter(
      :ignore_rabbitmq_progress_reports,
      {&:logger_filters.domain/2, {:stop, :equal, [:progress]}}
    )
    children = [
      # Start the Ecto repository
      Services.Repo,
      # Start the Telemetry supervisor
      ServicesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Services.PubSub},
      # Start the Endpoint (http/https)
      ServicesWeb.Endpoint,
      Services.ConsumerPool
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Services.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ServicesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
