defmodule DeploySample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DeploySample.Repo,
      # Start the Telemetry supervisor
      DeploySampleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DeploySample.PubSub},
      # Start the Endpoint (http/https)
      DeploySampleWeb.Endpoint
      # Start a worker by calling: DeploySample.Worker.start_link(arg)
      # {DeploySample.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DeploySample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DeploySampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
