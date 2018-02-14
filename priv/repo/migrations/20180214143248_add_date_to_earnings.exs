defmodule AtpDataElixir.Repo.Migrations.AddDateToEarnings do
  use Ecto.Migration

  def change do
    alter table("earnings") do
      add :date, :utc_datetime
    end
  end
end
