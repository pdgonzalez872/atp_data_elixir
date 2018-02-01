defmodule Mix.Tasks.FetchRankings do
  use Mix.Task

  def run(_) do
    AtpDataElixir.main()
  end
end
