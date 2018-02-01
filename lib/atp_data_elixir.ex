defmodule AtpDataElixir do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(AtpDataElixir.Repo, []),
      # Start the endpoint when the application starts
      supervisor(AtpDataElixir.Endpoint, []),
      # Start your own worker by calling: AtpDataElixir.Worker.start_link(arg1, arg2, arg3)
      # worker(AtpDataElixir.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AtpDataElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AtpDataElixir.Endpoint.config_change(changed, removed)
    :ok
  end

  # TODO:
  # Legacy -> move this out of here.
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
      Path.join(["test", "lib", "test_data", "urls.txt"])
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
      Path.join(["test", "lib", "test_data", "single_url.txt"])
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
