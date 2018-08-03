defmodule ChosenApiWeb.ReferenceControllerTest do
  use ChosenApiWeb.ConnCase

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Reference

  @create_attrs %{title: "some title", url: "some url"}
  @update_attrs %{title: "some updated title", url: "some updated url"}
  @invalid_attrs %{title: nil, url: nil}

  def fixture(:reference) do
    {:ok, reference} = Profiles.create_reference(@create_attrs)
    reference
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all references", %{conn: conn} do
      conn = get conn, reference_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_reference(_) do
    reference = fixture(:reference)
    {:ok, reference: reference}
  end
end
