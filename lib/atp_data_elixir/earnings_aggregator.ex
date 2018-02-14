defmodule AtpDataElixir.EarningsAggregator do
  alias AtpDataElixir.{Repo, Player, Earning}

  import Ecto.Query

  # Persist this in a table, super quick displays.
  # Sorted latest results. Each time we do a fetch it calls this function as well.

  def get_latest_earnings_for_players do
    Player
    |> Repo.all
    |> Enum.map(fn(player) ->
      get_latest_earnings_for_player(player)
    end)
    |> Enum.sort_by(fn(result) ->
      {_, _, amount} = result
      amount
    end)
    |> Enum.reverse()
  end

  def get_latest_earnings_for_player(player) do
    player_data = preload(Player, :earnings) |> Repo.get(player.id)
    latest_earnings = Enum.at(player_data.earnings, -1)

    { :ok, "#{player.first_name} #{player.last_name}", latest_earnings.amount }
  end
end
