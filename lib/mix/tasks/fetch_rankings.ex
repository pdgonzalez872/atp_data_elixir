defmodule Mix.Tasks.FetchRankings do
  use Mix.Task

  def run(_) do
    IO.puts "Starting"

    # Do time elapsed

    # request HTTPoison

    # pattern match response body

    # parse response body to get the target urls

    # Do something with that parsed body -> save it to files? in a list in memory?

    # Discuss strategy with Rapha ->
    #  One entity that distributes the elements in the list to other entities (a url to send a request to, )

    IO.puts "Finished in ... seconds"
  end
end
