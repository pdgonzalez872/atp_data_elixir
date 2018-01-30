defmodule AtpDataElixir do
  @moduledoc """
  Documentation for AtpDataElixir.
  """

  require Logger

  def main do
    Logger.info "Starting"
    start_time = Date.utc_today

    # create url file and retrieve text
    {:ok, text} = RankingPage.process

    text
    |> String.split("\n")
    |> Enum.each(fn(player_url) -> PlayerPage.process_player(player_url) end)

    # go through file and make requests to each of the players

    Logger.info "Finished in #{Date.diff(Date.utc_today, start_time)} seconds"
  end
end
