require IEx

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

    result = Path.join(["test", "test_data","urls.txt"])
    |> Path.absname
    |> File.stream!
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split(&1, "\n"))
    |> Flow.filter(fn(x) -> x != "" end)
    |> Flow.map(fn(player_url) -> PlayerPage.process_player(player_url) end)
    |> Enum.to_list()


    # |> Stream.flat_map(&String.split(&1, "\n"))
    # |> Stream.filter(fn(x) -> x != "" end)
    # |> Stream.map(fn(player_url) -> PlayerPage.process_player(player_url) end)
    # |> Enum.to_list()

    Logger.info("Finished in #{Date.diff(Date.utc_today, start_time)} seconds")
  end
end
