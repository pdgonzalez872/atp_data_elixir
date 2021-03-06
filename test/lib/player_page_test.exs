require IEx

defmodule PlayerPageTest do
  use ExUnit.Case
  doctest PlayerPage

  # TODO:
  # Would be cool to run this only in certain runs
  @tag :skip
  describe "integration test" do
    test "works in integration" do
      "/en/players/rafael-nadal/n409/overview"
      |> PlayerPage.process_player()

      # get a player url
      # combine it with the base url
      # send a request to that url
      # parse the response
      # return a map with the data and key that includes the string below:
      # ranking|first_name|last_name|country|birthday|prize_money

      assert 1 == 1
    end
  end

  describe "parse_html/1" do
    test "returns a map with the correct data" do
      html_string =
        Path.absname(Path.join(["test", "lib", "test_data", "roger.htm"]))
        |> File.read!()

      result = PlayerPage.parse_html(html_string)

      expected = %{
        birthday: "1981-08-08",
        country: "SUI",
        first_name: "Roger",
        last_name: "Federer",
        prize_money: "115050482",
        ranking: "2"
      }

      assert result == expected
    end

    test "returns a map even when there is no data" do
      html_string =
        Path.absname(Path.join(["test", "lib", "test_data", "bayard_empty.htm"]))
        |> File.read!()

      result = PlayerPage.parse_html(html_string)

      expected = %{
        birthday: "_",
        country: "FRA",
        first_name: "Damien",
        last_name: "Bayard",
        prize_money: "2074",
        ranking: "1189"
      }

      assert result == expected
    end
  end
end
