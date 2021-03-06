defmodule ChosenApiWeb.PodcasterControllerTest do
  use ChosenApiWeb.ConnCase

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Podcaster

  @create_attrs %{forename: "some forename", surname: "some surname"}
  @update_attrs %{forename: "some updated forename", surname: "some updated surname"}
  @invalid_attrs %{forename: nil, surname: nil}

  def fixture(:podcaster) do
    {:ok, podcaster} = Profiles.create_podcaster(@create_attrs)
    podcaster
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all podcasters", %{conn: conn} do
      conn = get conn, podcaster_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "update podcaster" do
    setup [:create_podcaster]

    test "renders podcaster when data is valid", %{conn: conn, podcaster: %Podcaster{id: id} = podcaster} do
      conn = put conn, podcaster_path(conn, :update, podcaster), podcaster: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, podcaster_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "forename" => "some updated forename",
        "surname" => "some updated surname"}
    end

    test "renders errors when data is invalid", %{conn: conn, podcaster: podcaster} do
      conn = put conn, podcaster_path(conn, :update, podcaster), podcaster: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_podcaster(_) do
    podcaster = fixture(:podcaster)
    {:ok, podcaster: podcaster}
  end
end
