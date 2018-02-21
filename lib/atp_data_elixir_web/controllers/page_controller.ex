defmodule AtpDataElixirWeb.PageController do
  use AtpDataElixirWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def chart_data(conn, _params) do
    player_data = AtpDataElixir.EarningsAggregator.get_latest_earnings

    # TODO: improve - iterating twice
    chart_labels = player_data
                   |> Enum.map(fn(el) -> %{ "amount" => _, "name" => name } = el; name end)

    chart_data = player_data
                 |> Enum.map(fn(el) -> %{ "amount" => amount, "name" => _ } = el; amount end)

    json(conn, [chart_labels, chart_data])
  end
end
