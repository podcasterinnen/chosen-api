defmodule ChosenApiWeb.PodcasterController do
  use ChosenApiWeb, :controller

  import ChosenApiWeb.Authorize

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Podcaster

  action_fallback ChosenApiWeb.FallbackController

  plug :id_check when action in [:update]

  def index(conn, %{"user_id" => user_id}) do
    podcaster = Profiles.get_podcaster_by_user_id!(user_id)
    render(conn, "show.json", podcaster: podcaster)
  end

  def index(conn, _params) do
    podcasters = Profiles.list_podcasters()
    render(conn, "index.json", podcasters: podcasters)
  end

  def create(conn, %{"podcaster" => podcaster_params}) do
    with {:ok, %Podcaster{} = podcaster} <- Profiles.create_podcaster(podcaster_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", podcaster_path(conn, :show, podcaster))
      |> render("show.json", podcaster: podcaster)
    end
  end

  def show(conn, %{"id" => id}) do
    podcaster = Profiles.get_podcaster!(id)
    render(conn, "show.json", podcaster: podcaster)
  end

  def update(conn, %{"id" => id, "podcaster" => podcaster_json, "avatar" => avatar}) do
    podcaster             = Profiles.get_podcaster!(id)
    podcaster_params      = Poison.decode!(podcaster_json)
    podcaster_with_avatar = Map.put(podcaster_params, "avatar", avatar)

    with {:ok, %Podcaster{} = podcaster} <- Profiles.update_podcaster(podcaster, podcaster_with_avatar) do
      render(conn, "show.json", podcaster: podcaster)
    end
  end

  def delete(conn, %{"id" => id}) do
    podcaster = Profiles.get_podcaster!(id)
    with {:ok, %Podcaster{}} <- Profiles.delete_podcaster(podcaster) do
      send_resp(conn, :no_content, "")
    end
  end
end
