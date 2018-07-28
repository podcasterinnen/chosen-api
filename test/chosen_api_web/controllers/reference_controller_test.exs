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

  describe "create reference" do
    test "renders reference when data is valid", %{conn: conn} do
      conn = post conn, reference_path(conn, :create), reference: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, reference_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "title" => "some title",
        "url" => "some url"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, reference_path(conn, :create), reference: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update reference" do
    setup [:create_reference]

    test "renders reference when data is valid", %{conn: conn, reference: %Reference{id: id} = reference} do
      conn = put conn, reference_path(conn, :update, reference), reference: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, reference_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "title" => "some updated title",
        "url" => "some updated url"}
    end

    test "renders errors when data is invalid", %{conn: conn, reference: reference} do
      conn = put conn, reference_path(conn, :update, reference), reference: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reference" do
    setup [:create_reference]

    test "deletes chosen reference", %{conn: conn, reference: reference} do
      conn = delete conn, reference_path(conn, :delete, reference)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, reference_path(conn, :show, reference)
      end
    end
  end

  defp create_reference(_) do
    reference = fixture(:reference)
    {:ok, reference: reference}
  end
end
