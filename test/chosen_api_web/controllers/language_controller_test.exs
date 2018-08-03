defmodule ChosenApiWeb.LanguageControllerTest do
  use ChosenApiWeb.ConnCase

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Language

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:language) do
    {:ok, language} = Profiles.create_language(@create_attrs)
    language
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all languages", %{conn: conn} do
      conn = get conn, language_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_language(_) do
    language = fixture(:language)
    {:ok, language: language}
  end
end
