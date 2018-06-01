defmodule Mix.Tasks.FetchData do
  use Mix.Task

  @doc "Runs the fetcher"
  def run(_) do
    AtpDataElixir.main()
  end
end
