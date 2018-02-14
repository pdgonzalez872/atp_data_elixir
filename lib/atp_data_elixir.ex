defmodule AtpDataElixir do
  @moduledoc """
  AtpDataElixir keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  require Logger

  alias AtpDataElixir.{Repo, Player, Earning}

  def main do
    fetch_rankings()
  end

  def fetch_rankings do
    Logger.info("Starting")

    HTTPoison.start()
    start_time = DateTime.utc_now()

    Logger.info("Fetching ranking page")
    {:ok, list_of_players} = RankingPage.process_and_keep_in_memory

    Logger.info("Fetch Complete")

    Logger.info("Fetching player data")

    results =
      list_of_players
      |> Flow.from_enumerable()
      |> Flow.partition(stages: 8)
      |> Flow.map(fn player_url -> PlayerPage.process_player(player_url) end)
      |> Enum.each(fn(result) -> persist_values(result) end)


    Logger.info("Finished in #{DateTime.diff(DateTime.utc_now(), start_time)} seconds")
  end

  def persist_values(result) do
    {_status, _url, {_string_representation, player_map}} = result

    player = case Repo.get_by(Player, first_name: player_map.first_name, last_name: player_map.last_name) do
      nil ->
        Logger.info "Didn't find player, will create #{player_map.first_name} #{player_map.last_name}"
        Repo.insert!(%Player{
          first_name: player_map.first_name,
          last_name: player_map.last_name,
          country: player_map.country,
          birthday: player_map.birthday
        })
      _ ->
        Logger.info "Found #{player_map.first_name} #{player_map.last_name}, will use it"
        Repo.get_by(Player, first_name: player_map.first_name, last_name: player_map.last_name)
    end

    {amount, _} = Integer.parse(player_map.prize_money)

    %Earning{amount: amount, player_id: player.id}
    |> Repo.insert!
  end
end
