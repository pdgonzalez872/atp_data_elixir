defmodule Mix.Tasks.FetchSingleRanking do
  use Mix.Task

  def run(_) do
    AtpDataElixir.single_fetch()
  end
end
