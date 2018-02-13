defmodule AtpDataElixir.Repo.Migrations.AddPlayerTable do
  use Ecto.Migration

  def up do
    create table("players") do
      add :ranking, :string
      add :first_name, :string
      add :last_name, :string
      add :country, :string
      add :birthday, :string

      timestamps()
    end
  end

  def down do
    drop table("players")
  end
end
