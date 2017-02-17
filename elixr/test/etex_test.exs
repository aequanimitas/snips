defmodule Elixr.EtexTest do
  use ExUnit.Case, async: true
  
  alias Elixr.Etex.Worker

  test "url_for should return valid url" do
    assert Worker.url_for("Manila") == "http://api.openweathermap.org/data/2.5/weather?q=Manila"
  end
end
