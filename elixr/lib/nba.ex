defmodule Elixr.Nba do

  defmodule Game do
    defstruct [
      :game_date, :game_sequence, :game_id, :game_status_id, :game_status,
      :game_code, :hometeam_id, :visitor_team_id, :season, :live_period,
      :live_pctime, :broadcaster_abbr, :live_bcast, :wh_status
    ]
    @type t :: %__MODULE__{game_date: String.t}
  end

  def init() do
    scores(Timex.today)
    |> parse_results
    |> JSON.decode!
    |> games_today
  end

  def scores(%Date{month: m, year: y, day: d} = _dte) do
    HTTPoison.request(:get, "http://stats.nba.com/stats/scoreboard/?LeagueId=00&DayOffset=0&GameDate=#{m}/#{d-1}/#{y}", "", [{"Referer", "https://stats.nba.com/scores/"}])
  end

  defp parse_results(result) do
    case result do
      {:ok, %HTTPoison.Response{body: body}} -> body
      _ -> "Fail miserably"
    end
  end

  @doc """

  """
  def games_today(json) do
    r = hd json["resultSets"]
    games = for row <- r["rowSet"] do
      for {k,v} <- Enum.zip(r["headers"], row) do
        %{"#{k}" => "#{v}"}
      end
    end
    for game <- games do
      to_game game
    end
  end

  def to_game([
    %{"GAME_DATE_EST" => game_date},
    %{"GAME_SEQUENCE" => game_sequence},
    %{"GAME_ID" => game_id},
    %{"GAME_STATUS_ID" => game_status_id},
    %{"GAME_STATUS_TEXT" => game_status},
    %{"GAMECODE" => game_code},
    %{"HOME_TEAM_ID" => hometeam_id},
    %{"VISITOR_TEAM_ID" => visitorteam_id},
    %{"SEASON" => season},
    %{"LIVE_PERIOD" => live_period},
    %{"LIVE_PC_TIME" => live_pctime},
    %{"NATL_TV_BROADCASTER_ABBREVIATION" => broadcaster_abbr},
    %{"LIVE_PERIOD_TIME_BCAST" => live_bcast},
    %{"WH_STATUS" => wh_status},
  ]) do
    %Game{
      game_status_id: game_status_id, 
      game_date: game_date,
      game_sequence: game_sequence,
      game_id: game_id, 
      game_status: game_status,
      game_code: game_code, 
      hometeam_id: hometeam_id,
      visitor_team_id: visitorteam_id, 
      season: season, 
      live_period: live_period,
      live_pctime: live_pctime, 
      broadcaster_abbr: broadcaster_abbr, 
      live_bcast: live_bcast, 
      wh_status: wh_status
    }
  end
end
