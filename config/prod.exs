use Mix.Config

config :atp_data_elixir, AtpDataElixirWeb.Endpoint,
  load_from_system_env: true,
  # http: [port: {:system, "PORT"}], # Uncomment this line if you are running Phoenix 1.2
  server: true, # Without this line, your app will not start the web server!
  secret_key_base: "${SECRET_KEY_BASE}",
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :atp_data_elixir, AtpDataElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "",
  ssl: true,
  pool_size: 1 # Free tier db only allows 1 connection

# Do not print debug messages in production
config :logger, level: :info
