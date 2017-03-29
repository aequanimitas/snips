#defmodule Elixr.Nba do
#
#  defmodule GameDay do
#    defstruct [:game_header,
#               :line_score,
#               :series_standings,
#               :last_meeting,
#               :data]
#  end
#
#  def init() do
#    url_for(DateTime.utc_now())
#    |> scores
#    |> parse_results
#    |> get_game_header
#  end
#
#  def scores(url) do
#    HTTPoison.request(:get, url, "", [{"Referer", "https://stats.nba.com/scores/"}])
#  end
#
#  defp parse_results(result) do
#    case result do
#      {:ok, %HTTPoison.Response{body: data}} ->
#        %GameDay{data: JSON.decode!(data)}
#      _ -> "Fail miserably"
#    end
#  end
#
#  def to_map(result_set) do
#    rset = for row <- result_set["rowSet"] do
#      for {k,v} <- Enum.zip(result_set["headers"], row) do
#        {"#{k}", "#{v}"}
#      end
#    end
#    Enum.map(rset, fn(rrow) -> Enum.into rrow, %{} end)
#  end
#
#  def url_for(%DateTime{month: m, year: y, day: d} = _dte) do
#    "http://stats.nba.com/stats/scoreboard/?LeagueId=00&DayOffset=0&GameDate=#{m}/#{d-1}/#{y}"
#  end
#
#  def get_game_header(%GameDay{data: data} = resultSets) do
#    game_header = to_map(hd data["resultSets"])
#    %GameDay{resultSets | game_header: game_header}
#  end
#end
