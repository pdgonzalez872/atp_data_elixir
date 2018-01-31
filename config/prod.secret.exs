use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :atp_data_elixir, AtpDataElixir.Endpoint,
  secret_key_base: "3lC8pZNCfuEn85bEJ+tqOhPTNL4RiMGS/1/xTmlGdQEotDlNHyYUOEdUDg6kize/"

# Configure your database
config :atp_data_elixir, AtpDataElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "atp_data_elixir_prod",
  pool_size: 15
