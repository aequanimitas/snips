defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def create(conn, %{"topic" => topic}) do
    # pass empty struct
    # conn.assigns[:user] or conn.assigns.user
    changeset = conn.assigns.user
      |> build_assoc(:topics)
      |>Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} -> 
        conn 
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} -> 
        conn
        |> put_flash(:error, "Something went wrong")
        |> render("new.html", changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    # topic is new changes
    # how to migrate from old_topic into new one
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def delete(conn, %{"id" => topic_id}) do
    # Query DB twice
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))

  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn
    user = Repo.get(Topic, topic_id)
    if user do
      if user.user_id == conn.assigns.user.id do
        conn
      end
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end
