require IEx

defmodule AcceptanceTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(AtpDataElixir.Repo)
  end

  describe "integration test" do
    test "works in integration" do
      alias AtpDataElixir.{Repo, Player, Earning}

      {:ok, player} = %Player{first_name: "Test"} |> Repo.insert

      %Earning{amount: 10000, player_id: player.id}
      |> Repo.insert!

      target_player = Player
      |> Repo.get_by(first_name: "Test")
      |> Repo.preload([:earnings])

      assert Enum.count(target_player.earnings) == 1

      target_earning = target_player.earnings
      |> Enum.take(-1)
      |> Enum.at(0)

      assert target_earning.amount == 10000
    end
  end
end
