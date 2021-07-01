# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :deploy_sample,
  ecto_repos: [DeploySample.Repo]

# Configures the endpoint
config :deploy_sample, DeploySampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "usTgZF59mlmRNhEaqJ0H6Df2NIldmzGXFzVWC8OPe02JmIxrewseRlUhbZlxgopi",
  render_errors: [view: DeploySampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DeploySample.PubSub,
  live_view: [signing_salt: "yVbOsY5f"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
