defmodule RankingPageTest do
  use ExUnit.Case
  doctest RankingPage

  test "greets the world" do
    assert RankingPage.call == nil
  end

  describe "build_url/1" do
    test "returns the correct url for a date" do
      result = RankingPage.build_url(~D[2018-01-28])
      expected = "http://www.atpworldtour.com/en/rankings/singles?rankDate=2018-1-22&rankRange=1-5000&countryCode=all"

      assert result == expected
    end
  end

  describe "last_monday/1" do
    test "returns the last Monday for a given date" do
      assert ~D[2018-01-22] == RankingPage.last_monday(~D[2018-01-28])
      assert ~D[2018-01-29] == RankingPage.last_monday(~D[2018-02-02])
    end
  end
end
