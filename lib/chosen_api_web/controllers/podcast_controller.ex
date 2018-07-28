defmodule ChosenApiWeb.PodcastController do
  use ChosenApiWeb, :controller

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Podcast

  action_fallback ChosenApiWeb.FallbackController

  def index(conn, _params) do
    podcasts = Profiles.list_podcasts()
    render(conn, "index.json", podcasts: podcasts)
  end

  def create(conn, %{"podcast" => podcast_params}) do
    with {:ok, %Podcast{} = podcast} <- Profiles.create_podcast(podcast_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", podcast_path(conn, :show, podcast))
      |> render("show.json", podcast: podcast)
    end
  end

  def show(conn, %{"id" => id}) do
    podcast = Profiles.get_podcast!(id)
    render(conn, "show.json", podcast: podcast)
  end

  def update(conn, %{"id" => id, "podcast" => podcast_params}) do
    podcast = Profiles.get_podcast!(id)

    with {:ok, %Podcast{} = podcast} <- Profiles.update_podcast(podcast, podcast_params) do
      render(conn, "show.json", podcast: podcast)
    end
  end

  def delete(conn, %{"id" => id}) do
    podcast = Profiles.get_podcast!(id)
    with {:ok, %Podcast{}} <- Profiles.delete_podcast(podcast) do
      send_resp(conn, :no_content, "")
    end
  end
end
