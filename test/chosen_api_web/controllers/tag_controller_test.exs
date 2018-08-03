defmodule ChosenApiWeb.TagControllerTest do
  use ChosenApiWeb.ConnCase

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Tag

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:tag) do
    {:ok, tag} = Profiles.create_tag(@create_attrs)
    tag
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tags", %{conn: conn} do
      conn = get conn, tag_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_tag(_) do
    tag = fixture(:tag)
    {:ok, tag: tag}
  end
end
