# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :atp_data_elixir,
  ecto_repos: [AtpDataElixir.Repo]

# Configures the endpoint
config :atp_data_elixir, AtpDataElixir.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "t+e72xYXK5pnd0nRvjn5eEy0b6n/YFxty0E+dYwCrnmJ7YRyf2t5BBZF7q6BUB5R",
  render_errors: [view: AtpDataElixir.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AtpDataElixir.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
