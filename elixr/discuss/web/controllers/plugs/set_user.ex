defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User

  def init(_params) do
    # do expensive operations here, going to be run once
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)
    cond do
      user = user_id && Repo.get(User, user_id) ->
        # do it the FP way, call a function to transform the conn object
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil) 
    end
  end
end
