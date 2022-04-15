defmodule ChosenApiWeb.PodcasterControllerTest do
  use ChosenApiWeb.ConnCase
  import ChosenApiWeb.AuthCase
  alias ChosenApi.Profiles

  @create_attrs %{forename: "some forename", surname: "some surname"}

  def fixture(:podcaster) do
    {:ok, podcaster} = Profiles.create_podcaster(@create_attrs)
    podcaster
  end

  setup %{conn: conn} do
    user = add_user_confirmed("reg@fnord.com")
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user}
  end

  describe "index" do
    test "lists all podcasters", %{conn: conn} do
      conn = get conn, podcaster_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "update podcaster" do
    setup [:create_podcaster]

    test "renders podcaster when data is valid", %{conn: conn, user: user} do
      {:ok, podcaster} = Profiles.create_podcaster(%{
        forename: "some forename",
        surname: "some surname",
        user_id: user.id
      })

      auth_conn = conn
                  |> post(session_path(conn, :create), session: %{email: "reg@fnord.com", password: "reallyHard2gue$$"})

      assert json_response(auth_conn, 200)

      avatar = %Plug.Upload{path: "test/fixtures/avatar.jpg", filename: "avatar.jpg"}

      {:ok, json_params} = Jason.encode(%{
        forename: "some updated forename",
        surname: "some updated surname",
        id: podcaster.id
      })

      response = auth_conn
                 |> put(podcaster_path(conn, :update, user.id), podcaster: json_params, avatar: avatar)
                 |> json_response(200)

      assert podcaster.id == response["data"]["id"]

      conn = get conn, podcaster_path(conn, :show, podcaster.id)
      assert get_response = json_response(conn, 200)

      assert get_response["data"]["id"] == podcaster.id
      assert get_response["data"]["forename"] == "some updated forename"
      assert get_response["data"]["surname"] == "some updated surname"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      {:ok, podcaster} = Profiles.create_podcaster(%{
        forename: "some forename",
        surname: "some surname",
        user_id: user.id
      })

      auth_conn = conn
                  |> post(session_path(conn, :create), session: %{email: "reg@fnord.com", password: "reallyHard2gue$$"})

      assert json_response(auth_conn, 200)

      avatar = %Plug.Upload{path: "test/fixtures/avatar.jpg", filename: "avatar.jpg"}

      {:ok, json_params} = Jason.encode(%{
        forename: nil,
        surname: nil,
        id: podcaster.id
      })

      auth_conn
      |> put(podcaster_path(conn, :update, user.id), podcaster: json_params, avatar: avatar)
      |> json_response(422)
    end
  end

  defp create_podcaster(_) do
    podcaster = fixture(:podcaster)
    {:ok, podcaster: podcaster}
  end
end
