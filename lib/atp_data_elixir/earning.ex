defmodule AtpDataElixir.Earning do
  use Ecto.Schema

  schema "earnings" do
    field :amount, :integer
    timestamps()
  end
end
