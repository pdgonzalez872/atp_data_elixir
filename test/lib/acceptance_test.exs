require IEx

defmodule AcceptanceTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(AtpDataElixir.Repo)
  end

  describe "integration test" do
    test "works in integration" do
      #player = %AtpDataElixir.Player{first_name: "Paulo"}

      result = AtpDataElixir.Player
      |> AtpDataElixir.Repo.all
      |> Enum.count
      assert 0 == result
    end
  end
end
