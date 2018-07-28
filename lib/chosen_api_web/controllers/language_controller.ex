defmodule ChosenApiWeb.LanguageController do
  use ChosenApiWeb, :controller

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Language

  action_fallback ChosenApiWeb.FallbackController

  def index(conn, _params) do
    languages = Profiles.list_languages()
    render(conn, "index.json", languages: languages)
  end

  def create(conn, %{"language" => language_params}) do
    with {:ok, %Language{} = language} <- Profiles.create_language(language_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", language_path(conn, :show, language))
      |> render("show.json", language: language)
    end
  end

  def show(conn, %{"id" => id}) do
    language = Profiles.get_language!(id)
    render(conn, "show.json", language: language)
  end

  def update(conn, %{"id" => id, "language" => language_params}) do
    language = Profiles.get_language!(id)

    with {:ok, %Language{} = language} <- Profiles.update_language(language, language_params) do
      render(conn, "show.json", language: language)
    end
  end

  def delete(conn, %{"id" => id}) do
    language = Profiles.get_language!(id)
    with {:ok, %Language{}} <- Profiles.delete_language(language) do
      send_resp(conn, :no_content, "")
    end
  end
end
