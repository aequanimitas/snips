defmodule CacheTest do
  use ExUnit.Case, async: true

  alias Lye.IssueTracker.{Cache, Server}

  import Logger

  setup do
    {:ok, cache} = Cache.start
    {:ok, cache: cache}
  end

  test "spawns a cache", %{cache: cache} do
    assert is_pid(cache)
  end

  test "create a server process from cache", %{cache: cache} do
    sp = Cache.server_process cache, "test_db"
    assert is_pid sp
  end

  test "storing", %{cache: cache} do
    sp = Cache.server_process cache, "xy_"
    assert Server.add(sp, "test content")
    assert length(Server.all(sp)) > 0
  end
end
