defmodule AtpDataElixirWeb.PageController do
  use AtpDataElixirWeb, :controller

  alias AtpDataElixir.{EarningsAggregator}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def chart_data(conn, _params) do
    # TODO: https://github.com/pdgonzalez872/atp_data_elixir/issues/50
    player_data = EarningsAggregator.get_latest_earnings_for_players()

    # TODO: improve - iterating twice
    # https://stackoverflow.com/questions/45934946/compare-and-reduce-pairs-in-two-lists
    chart_labels =
      player_data
      |> Enum.map(fn el ->
        %{ amount:  _, name: name } = el
        name
      end)

    chart_data =
      player_data
      |> Enum.map(fn(el) ->
        %{ amount: amount, name: _ } = el;
        amount
      end)

    json(conn, [chart_labels, chart_data])
  end
end
