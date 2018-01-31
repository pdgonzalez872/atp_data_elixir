defmodule RankingPage do

  @rankings_base_url "http://www.atpworldtour.com/en/rankings/singles?"
  @rankings_rest_url "&rankRange=1-5000&countryCode=all"

  def process do
    build_url(Date.utc_today)
    |> fetch_data
    |> player_data
    |> Enum.map(fn(url) -> RankingPage.parse_individual_element(url) end)
    |> create_text_file_with_urls(Path.join(["test", "test_data","urls.txt"]))
  end

  @doc """
  Returns a valid rankings url from the ATP website
  """
  def build_url(date) do
    %{year: year, month: month, day: day} = last_monday(date)
    "#{@rankings_base_url}rankDate=#{year}-#{month}-#{day}#{@rankings_rest_url}"
  end

  @doc """
  Returns the last Monday for a given date
  ## Examples
      iex> RankingPage.last_monday(~D[2018-01-30])
      ~D[2018-01-29]
  """
  def last_monday(date) do
    Timex.beginning_of_week(date)
  end

  @doc """
  Fetches html from a url
  """
  def fetch_data(url) do
    %{body: body} = HTTPoison.get!(url)
    body
  end

  @doc """
  Parses html and returns a list with the players urls
  """
  def player_data(html_string) do
    Floki.find(html_string, ".player-cell a")
  end

  def parse_individual_element(el) do
    {_, [{_, url}, {_, _}], [_]} = el
    url
  end

  def create_text_file_with_urls(urls, path) do
    full_path = Path.absname(path)
    File.write(full_path, Enum.join(urls, "\n"), [:write])
    File.read(full_path)
  end
end
