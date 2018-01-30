defmodule AtpDataElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :atp_data_elixir,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :timex, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:floki, "~> 0.19.0"},
      {:timex, "~> 3.0"}
    ]
  end
end
