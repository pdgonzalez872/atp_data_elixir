defmodule AtpDataElixir.Repo.Migrations.EarningsBelongsToPlayer do
  use Ecto.Migration

  def change do
    alter table("earnings") do
      add :player_id, references("players")
    end
  end
end
