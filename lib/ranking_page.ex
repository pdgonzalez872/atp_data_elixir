defmodule RankingPage do

  @rankings_base_url "http://www.atpworldtour.com/en/rankings/singles?"
  @rankings_rest_url "&rankRange=1-5000&countryCode=all"

  # sends the request to the correct url
  def call do
    # result = url
    # |> build_url
    # |> fetch_data
    # |> parse_html
    # Then pass the result back below
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
end
