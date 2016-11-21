defmodule Discuss.Plugs.RequireAuth do

  import Plug.Conn # make halt available in context
  import Phoenix.Controller # for put_flash and redirect
  
  alias Discuss.Router.Helpers # for path helper, Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn 
      |> put_flash(:error, "You must be logged in")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end
end
