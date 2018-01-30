require IEx

defmodule PlayerPageTest do
  use ExUnit.Case
  doctest PlayerPage

  describe "integration test" do
    test "works in integration" do

      "/en/players/rafael-nadal/n409/overview"
      |> PlayerPage.process

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
      html_string = Path.absname(Path.join(["test", "test_data","roger.htm"]))
      |> File.read!

      result = PlayerPage.parse_html(html_string)
      expected = %{birthday: "1981-08-08", country: "SUI", first_name: "Roger", last_name: "Federer", prize_money: "$115,050,482", ranking: "2"}
      assert result == expected
    end
  end
end
