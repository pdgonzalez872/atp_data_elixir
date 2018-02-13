require IEx

defmodule AcceptanceTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(AtpDataElixir.Repo)
  end

  describe "integration test" do
    test "works in integration" do

      alias AtpDataElixir.{Repo, Player, Earning}

      %Player{first_name: "Test"} |> Repo.insert

      earning = %Earning{amount: 10000}
      |> Repo.insert

      target_player = Repo.get_by(Player, first_name: "Test") |> Repo.preload([:earnings])

      assert target_player.earnings == []

      player_changeset = Ecto.Changeset.change(target_player, earnings: [earning])

      # This fails. Here is the error:
      #   pry(1)> player_changeset = Ecto.Changeset.change(target_player, earnings: [earning])
      #   #Ecto.Changeset<
      #     action: nil,
      #       changes: %{},
      #       errors: [earnings: {"is invalid", [type: {:array, :map}]}],
      #       data: #AtpDataElixir.Player<>,
      #     valid?: false
      #   >

      refute target_player.earnings == []
      assert Enum.count(target_player.earnings) == 1
    end
  end
end
