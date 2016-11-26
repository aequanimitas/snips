defmodule Elixr.Nba do
  def scores() do
    HTTPoison.request(:get, "http://stats.nba.com/stats/scoreboard/?LeagueId=00&DayOffset=0&GameDate=11/25/2016", "", [{"Referer", "https://stats.nba.com/scores/"}])
  end
end
