defmodule ChosenApiWeb.TagController do
  use ChosenApiWeb, :controller

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Tag

  action_fallback ChosenApiWeb.FallbackController

  def index(conn, _params) do
    tags = Profiles.list_tags()
    render(conn, "index.json", tags: tags)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Profiles.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tag_path(conn, :show, tag))
      |> render("show.json", tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Profiles.get_tag!(id)
    render(conn, "show.json", tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Profiles.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Profiles.update_tag(tag, tag_params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Profiles.get_tag!(id)
    with {:ok, %Tag{}} <- Profiles.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
