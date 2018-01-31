require IEx

defmodule AtpDataElixir do
  @moduledoc """
  Documentation for AtpDataElixir.
  """

  require Logger

  def main do
    HTTPoison.start()

    Logger.info("Starting")
    start_time = DateTime.utc_now()

    Logger.info("Fetching ranking page and create URL file")
    {:ok, _} = RankingPage.process()
    Logger.info("Fetch Complete, File created")

    Logger.info("Fetching player data")

    result =
      Path.join(["test", "test_data", "urls.txt"])
      |> Path.absname()
      |> File.stream!()
      |> Flow.from_enumerable()
      |> Flow.partition(stages: 8)
      |> Flow.flat_map(&String.split(&1, "\n"))
      |> Flow.filter(fn x -> x != "" end)
      |> Flow.map(fn player_url -> PlayerPage.process_player(player_url) end)
      |> Enum.to_list()

    today = Date.utc_today()

    file_name =
      Enum.join(
        [
          today.year,
          String.pad_leading(Integer.to_string(today.month), 2, "0"),
          String.pad_leading(Integer.to_string(today.day), 2, "0")
        ],
        ""
      )

    to_write =
      Enum.map(result, fn x ->
        {_, _, data} = x
        data
      end)
      |> Enum.sort_by(fn x -> String.split(x, "|") |> Enum.at(-1) |> Integer.parse() end)
      |> Enum.reverse()

    file_path =
      Path.join(["test", "test_data", "data_files", "#{file_name}_rankings.txt"])
      |> Path.absname()

    File.write(file_path, "ranking|first_name|last_name|country|birthday|prize_money\n")
    File.write(file_path, Enum.join(to_write, "\n"), [:append])

    Logger.info("Finished in #{DateTime.diff(DateTime.utc_now(), start_time)} seconds")
  end

  def single_fetch do
    HTTPoison.start()

    Logger.info("Starting Single Fetch")
    start_time = DateTime.utc_now()
    Logger.info("Fetching player data")

    result =
      Path.join(["test", "test_data", "single_url.txt"])
      |> Path.absname()
      |> File.stream!()
      |> Flow.from_enumerable()
      |> Flow.partition(stages: 8)
      |> Flow.flat_map(&String.split(&1, "\n"))
      |> Flow.filter(fn x -> x != "" end)
      |> Flow.map(fn player_url -> PlayerPage.process_player(player_url) end)
      |> Enum.to_list()

    today = Date.utc_today()

    file_name =
      Enum.join(
        [
          today.year,
          String.pad_leading(Integer.to_string(today.month), 2, "0"),
          String.pad_leading(Integer.to_string(today.day), 2, "0")
        ],
        ""
      )

    to_write =
      Enum.map(result, fn x ->
        {_, _, data} = x
        data
      end)
      |> Enum.sort_by(fn x -> String.split(x, "|") |> Enum.at(-1) |> Integer.parse() end)
      |> Enum.reverse()

    file_path =
      Path.join(["test", "test_data", "data_files", "#{file_name}_single_fetch_rankings.txt"])
      |> Path.absname()

    File.write(file_path, "ranking|first_name|last_name|country|birthday|prize_money\n")
    File.write(file_path, Enum.join(to_write, "\n"), [:append])

    Logger.info("Finished in #{DateTime.diff(DateTime.utc_now(), start_time)} seconds")
    {:ok}
  end
end
