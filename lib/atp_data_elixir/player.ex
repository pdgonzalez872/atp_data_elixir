defmodule AtpDataElixir.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field(:ranking, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:country, :string)
    field(:birthday, :string)
    has_many(:earnings, AtpDataElixir.Earning)
    timestamps()
  end
end
