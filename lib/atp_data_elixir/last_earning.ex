defmodule AtpDataElixir.LastEarning do
  use Ecto.Schema
  import Ecto.Changeset

  schema "last_earnings" do
    field(:results, :string)
    field(:date, :utc_datetime)
    timestamps()
  end
end
