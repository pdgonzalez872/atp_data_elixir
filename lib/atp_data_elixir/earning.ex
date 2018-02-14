defmodule AtpDataElixir.Earning do
  use Ecto.Schema
  import Ecto.Changeset

  schema "earnings" do
    field(:amount, :integer)
    belongs_to(:player, AtpDataElixir.Player)
    timestamps()
  end
end
