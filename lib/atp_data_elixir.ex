defmodule AtpDataElixir do
  @moduledoc """
  This module is reponsible for putting the whole system in motion.
  It is the entry point to fetching data from the ATP rankings.
  """

  require Logger

  alias AtpDataElixir.{Repo, Player, Earning}

  def main do
    fetch_rankings()
  end

  defp fetch_rankings do
    # Need to make all applications run here.
    Application.ensure_all_started(:atp_data_elixir)

    Logger.info("Starting")

    HTTPoison.start()
    start_time = DateTime.utc_now()

    Logger.info("Fetching ranking page")
    {:ok, list_of_players} = RankingPage.process_and_keep_in_memory()

    Logger.info("Fetch Complete")

    Logger.info("Fetching player data")

    list_of_players
    |> Flow.from_enumerable()
    |> Flow.partition(stages: 8)
    |> Flow.map(fn player_url ->
      PlayerPage.process_player(player_url) |> persist_values()
    end)
    |> Enum.to_list()

    Logger.info("Finished in #{DateTime.diff(DateTime.utc_now(), start_time)} seconds")
  end

  defp persist_values(result) do
    {_status, _url, {_string_representation, player_map}} = result

    player =
      case Repo.get_by(Player, first_name: player_map.first_name, last_name: player_map.last_name) do
        nil ->
          Logger.info(
            "Didn't find player, will create #{player_map.first_name} #{player_map.last_name}"
          )

          Repo.insert!(%Player{
            first_name: player_map.first_name,
            last_name: player_map.last_name,
            country: player_map.country,
            birthday: player_map.birthday
          })

        _ ->
          Logger.info("Found #{player_map.first_name} #{player_map.last_name}, will use it")
          Repo.get_by(Player, first_name: player_map.first_name, last_name: player_map.last_name)
      end

    {amount, _} = Integer.parse(player_map.prize_money)

    %Earning{amount: amount, player_id: player.id, date: DateTime.utc_now()}
    |> Repo.insert!()
  end
end
