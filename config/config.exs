# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :datalocker,
  ecto_repos: [Datalocker.Repo]

# Configures the endpoint
config :datalocker, Datalocker.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OxLcse1d5KoWLFHDKhPIRGBVF5CPsMbsasFcuVsIf3B7WEgoFhrSLcezf71LM3g/",
  render_errors: [view: Datalocker.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Datalocker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
