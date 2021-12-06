defmodule TransportApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TransportApi.Repo,
      # Start the Telemetry supervisor
      TransportApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TransportApi.PubSub},
      # Start the Endpoint (http/https)
      TransportApiWeb.Endpoint
      # Start a worker by calling: TransportApi.Worker.start_link(arg)
      # {TransportApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TransportApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TransportApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
