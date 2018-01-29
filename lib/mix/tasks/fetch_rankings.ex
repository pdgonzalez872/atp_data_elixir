defmodule Mix.Tasks.FetchRankings do
  use Mix.Task

  require Logger

  def run(_) do
    Logger.info "Starting"

    ############################################
    # Do time elapsed


    # request HTTPoison

    # pattern match response body

    # parse response body to get the target urls

    # Do something with that parsed body -> save it to files? in a list in memory?

    # Discuss strategy with Rapha ->
    # I will have a list with many urls. This is what I have in mind:
    #  - One entity that distributes the elements in the list to other entities (a url, string) - A Supervisor?
    #  - each process that gets that url then sends a request to it, gets contents, parses contents and returns a map with the results
    # I want to do the above concurrently. I'd like to create 2,500 requests at the same time.
    ############################################

    Logger.info "Finished in ... seconds"
  end
end
