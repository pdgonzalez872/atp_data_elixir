defmodule AtpDataElixirWeb.PageController do
  use AtpDataElixirWeb, :controller

  def index(conn, _params) do
    #player_data = AtpDataElixir.EarningsAggregator.get_latest_earnings_for_players
    player_data = []
    chart_labels = AtpDataElixir.EarningsAggregator.chart_labels
    chart_data = AtpDataElixir.EarningsAggregator.chart_data

    render(conn, "index.html", player_data: player_data, chart_labels: chart_labels, chart_data: chart_data)
  end
end
