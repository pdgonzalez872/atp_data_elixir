defmodule AtpDataElixirWeb.PageController do
  use AtpDataElixirWeb, :controller

  alias AtpDataElixir.{EarningsAggregator}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def chart_data(conn, _params) do
    # TODO: https://github.com/pdgonzalez872/atp_data_elixir/issues/50
    player_data = EarningsAggregator.get_latest_earnings_for_players()

    {chart_labels, chart_data} =
      player_data
      |> Enum.reduce({[], []}, fn el, {chart_labels, chart_data} ->
        %{amount: amount, name: name} = el
        {chart_labels ++ [name], chart_data ++ [amount]}
      end)

    json(conn, [chart_labels, chart_data])
  end
end
