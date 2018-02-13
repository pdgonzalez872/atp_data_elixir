defmodule AtpDataElixir.Repo.Migrations.AddEarnings do
  use Ecto.Migration

  def change do
    create table("earnings") do
      add :amount, :integer

      timestamps()
    end
  end
end
