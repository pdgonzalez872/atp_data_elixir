use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :atp_data_elixir, AtpDataElixirWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :atp_data_elixir, AtpDataElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "atp_data_elixir_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  # more time to play around in IEx
  ownership_timeout: 10 * 6 * 1000
