require IEx

defmodule RankingPageTest do
  use ExUnit.Case
  doctest RankingPage

  describe "integration test" do
    test "works in integration" do
    end
  end

  describe "build_url/1" do
    test "returns the correct url for a date" do
      result = RankingPage.build_url(~D[2018-01-28])

      expected =
        "http://www.atpworldtour.com/en/rankings/singles?rankDate=2018-1-22&rankRange=1-5000&countryCode=all"

      assert result == expected
    end
  end

  describe "last_monday/1" do
    test "returns the last Monday for a given date" do
      assert ~D[2018-01-22] == RankingPage.last_monday(~D[2018-01-28])
      assert ~D[2018-01-29] == RankingPage.last_monday(~D[2018-02-02])
    end
  end

  describe "player_data/1" do
    test "parses html and returns a list with the players urls" do
      html_string =
        Path.absname(Path.join(["test", "lib", "test_data", "rankings_page.html"]))
        |> File.read!()

      result = RankingPage.player_data(html_string)

      expected =
        {"a",
         [
           {"href", "/en/players/rafael-nadal/n409/overview"},
           {"data-ga-label", "Rafael Nadal"}
         ], ["Rafael Nadal"]}

      assert Enum.at(result, 0) == expected
    end

    test "parses html and returns a list with the players urls - with the new ranking page 20180719" do
      html_string =
        Path.absname(Path.join(["test", "lib", "test_data", "rankings_page_20180719.html"]))
        |> File.read!()

      result = RankingPage.player_data(html_string)

      expected =
        {"a",
         [
           {"href", "/en/players/rafael-nadal/n409/overview"},
           {"data-ga-label", "Rafael Nadal"}
         ], ["Rafael Nadal"]}

      assert Enum.at(result, 0) == expected
    end
  end

  describe "parse_individual_element/1" do
    test "returns the url from a data structure" do
      result =
        {"a",
         [
           {"href", "/en/players/rafael-nadal/n409/overview"},
           {"data-ga-label", "Rafael Nadal"}
         ], ["Rafael Nadal"]}

      assert RankingPage.parse_individual_element(result) ==
               "/en/players/rafael-nadal/n409/overview"
    end
  end

  describe "create_text_file_with_urls/1" do
    test "creates a file with the list we pass in - eventually deprecate this and not save it to disk" do
      result =
        RankingPage.create_text_file_with_urls(
          ["first_url", "second_url"],
          Path.join(["test", "lib", "test_data", "urls.txt"])
        )

      {:ok, text} = result
      assert text == "first_url\nsecond_url"
    end
  end
end
