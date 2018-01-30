defmodule AtpDataElixir do
  @moduledoc """
  Documentation for AtpDataElixir.
  """

  require Logger

  def main do
    Logger.info("Starting")
    start_time = Date.utc_today

    Logger.info("Fetching ranking page and create URL file")
    {:ok, text} = RankingPage.process
    Logger.info("Fetch Complete, File created")

    Logger.info("Fetching player data")
    list = text
    |> String.split("\n")
    |> Enum.map(fn(player_url) -> PlayerPage.process_player(player_url) end)

    # Let's implement flow now.



    Logger.info("Finished in #{Date.diff(Date.utc_today, start_time)} seconds")
  end
end
