defmodule ChosenApiWeb.PodcastControllerTest do
  use ChosenApiWeb.ConnCase

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Podcast

  @create_attrs %{title: "some title", url: "some url"}
  @update_attrs %{title: "some updated title", url: "some updated url"}
  @invalid_attrs %{title: nil, url: nil}

  def fixture(:podcast) do
    {:ok, podcast} = Profiles.create_podcast(@create_attrs)
    podcast
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all podcasts", %{conn: conn} do
      conn = get conn, podcast_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_podcast(_) do
    podcast = fixture(:podcast)
    {:ok, podcast: podcast}
  end
end
