defmodule AtpDataElixir.Player do
  use Ecto.Schema

  schema "player" do
    field :ranking, :string
    field :first_name, :string
    field :last_name, :string
    field :country, :string
    field :birthday, :string
    timestamps()
  end
end
