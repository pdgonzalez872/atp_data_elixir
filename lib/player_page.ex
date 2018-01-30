require IEx

defmodule PlayerPage do
  def process(url) do
    # result = url
    # |> fetch_data
    # |> parse_html
    # Then pass the result back below
    {:ok, url}
  end

  def fetch_data(url) do
    HTTPoison.start
    %{body: body} = HTTPoison.get!(url)
    body
  end

  # parses request with library and returns tuple
  # returns  tuple
  def parse_html(html) do
    %{
      ranking: parse_ranking(html),
      first_name: parse_first_name(html),
      last_name: parse_last_name(html),
      country: parse_country(html),
      birthday: parse_birthday(html),
      prize_money: parse_career_prize_money(html)
    }
  end

  def parse_ranking(html) do
    [{_, [{_, _}, {_, _}], [ranking_dirty]}] = Floki.find(html, ".player-ranking-position .data-number")

    ranking_dirty
    |> String.trim
  end

  def parse_first_name(html) do
    [{_, [{_, _}], [first_name]}] = Floki.find(html, ".player-profile-hero-name .first-name")
    first_name
  end

  def parse_last_name(html) do
    [{_, [{_, _}], [last_name]}] = Floki.find(html, ".player-profile-hero-name .last-name")
    last_name
  end

  def parse_country(html) do
    [{_, [{_, _}], [country]}] = Floki.find(html, ".player-flag-code")
    country
  end

  def parse_birthday(html) do
    [{_, [{_, _}], [birthday_dirty]}] = Floki.find(html, ".table-birthday")

    birthday_clean = birthday_dirty
    |> String.replace("(", "")
    |> String.replace(")", "")
    |> String.replace(".", "-")
    |> String.trim

    birthday_clean
  end

  def parse_career_prize_money(html) do
    {_, [{_, _}, {_, _}, {_, _}], [dirty_prize_money]} = Enum.at(Floki.find(html, ".players-stats-table .stat-value"), -1)
    dirty_prize_money
    |> String.trim
  end
end
