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

  describe "create podcast" do
    test "renders podcast when data is valid", %{conn: conn} do
      conn = post conn, podcast_path(conn, :create), podcast: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, podcast_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "title" => "some title",
        "url" => "some url"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, podcast_path(conn, :create), podcast: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update podcast" do
    setup [:create_podcast]

    test "renders podcast when data is valid", %{conn: conn, podcast: %Podcast{id: id} = podcast} do
      conn = put conn, podcast_path(conn, :update, podcast), podcast: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, podcast_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "title" => "some updated title",
        "url" => "some updated url"}
    end

    test "renders errors when data is invalid", %{conn: conn, podcast: podcast} do
      conn = put conn, podcast_path(conn, :update, podcast), podcast: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete podcast" do
    setup [:create_podcast]

    test "deletes chosen podcast", %{conn: conn, podcast: podcast} do
      conn = delete conn, podcast_path(conn, :delete, podcast)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, podcast_path(conn, :show, podcast)
      end
    end
  end

  defp create_podcast(_) do
    podcast = fixture(:podcast)
    {:ok, podcast: podcast}
  end
end
