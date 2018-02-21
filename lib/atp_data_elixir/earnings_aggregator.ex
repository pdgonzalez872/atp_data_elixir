defmodule AtpDataElixir.EarningsAggregator do
  alias AtpDataElixir.{Repo, Player, Earning}

  import Ecto.Query

  # Persist this in a table, super quick displays.
  # Sorted latest results. Each time we do a fetch it calls this function as well.

  def get_latest_earnings_for_players do
    results =
      Player
      |> Repo.all()
      |> Enum.map(fn player ->
        get_latest_earnings_for_player(player)
      end)
      |> Enum.sort_by(fn result ->
        %{name: name, amount: amount} = result
        amount
      end)
      |> Enum.reverse()

    results |> Jason.encode!
  end

  def get_latest_earnings_for_player(player) do
    player_data = preload(Player, :earnings) |> Repo.get(player.id)
    latest_earnings = Enum.at(player_data.earnings, -1)

    %{name: "#{player.first_name} #{player.last_name}", amount: latest_earnings.amount}
  end

  def chart_labels do
    Jason.encode! ["Paulo", "Rapha"]
  end

  def chart_data do
    Jason.encode! ["1" , "2"]
  end
end
