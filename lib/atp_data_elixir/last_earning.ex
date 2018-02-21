defmodule AtpDataElixir.LastEarning do
  use Ecto.Schema
  import Ecto.Changeset

  schema "last_earnings" do
    field(:result, :map)
    field(:date, :utc_datetime)
    timestamps()
  end
end
