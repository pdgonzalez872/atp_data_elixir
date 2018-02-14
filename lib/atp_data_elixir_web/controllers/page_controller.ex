defmodule AtpDataElixirWeb.PageController do
  use AtpDataElixirWeb, :controller

  def index(conn, _params) do
    player_data = AtpDataElixir.EarningsAggregator.get_latest_earnings_for_players

    render(conn, "index.html", player_data: player_data)
  end
end
