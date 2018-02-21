defmodule AtpDataElixir.Repo.Migrations.AddLastEarningsTable do
  use Ecto.Migration

  def change do
    create table(:last_earnings) do
      add :results, :json
      add :date, :utc_datetime
    end
  end
end
