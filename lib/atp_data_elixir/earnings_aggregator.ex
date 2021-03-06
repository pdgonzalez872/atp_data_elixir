defmodule AtpDataElixir.EarningsAggregator do
  alias AtpDataElixir.{Repo, Player, LastEarning}

  import Ecto.Query

  @doc ~S"""
  Gets the latest earnings for each player.
  """
  def get_latest_earnings_for_players do
    results =
      Player
      |> Repo.all()
      |> Enum.map(fn player ->
        get_latest_earnings_for_player(player)
      end)
      |> Enum.sort_by(fn result ->
        %{name: _, amount: amount} = result
        amount
      end)
      |> Enum.reverse()

    results
  end

  # TODO:
  # https://github.com/pdgonzalez872/atp_data_elixir/issues/50
  def get_latest_earnings_for_player(player) do
    player_data = preload(Player, :earnings) |> Repo.get(player.id)
    latest_earnings = Enum.at(player_data.earnings, -1)

    %{name: "#{player.first_name} #{player.last_name}", amount: latest_earnings.amount}
  end

  # TODO:
  # https://github.com/pdgonzalez872/atp_data_elixir/issues/50
  def get_and_persist_latest_earnings_for_players do
    encoded_json_object =
      get_latest_earnings_for_players()
      |> Jason.encode!()

    Repo.insert!(%LastEarning{results: encoded_json_object, date: DateTime.utc_now()})
  end

  # TODO:
  # https://github.com/pdgonzalez872/atp_data_elixir/issues/50
  def get_latest_earnings() do
    result =
      LastEarning
      |> Ecto.Query.last()
      |> Repo.one()

    %AtpDataElixir.LastEarning{results: json_result} = result
    Jason.decode!(json_result)
  end
end
