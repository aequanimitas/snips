defmodule Elixr.NbaTest do
  use ExUnit.Case, async: true

  alias Elixr.Nba
  
  @valid_url "http://stats.nba.com/stats/scoreboard/?LeagueId=00&DayOffset=0&GameDate=2/8/2017"
  test "url_for should return date 02/08/17" do
    assert Nba.url_for(DateTime.utc_now) == @valid_url
  end
end
