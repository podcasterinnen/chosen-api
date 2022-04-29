defmodule ChosenApiWeb.UserControllerTest do
  use ChosenApiWeb.ConnCase

  import ChosenApiWeb.AuthCase
  alias ChosenApi.Accounts

  @create_attrs %{email: "reg@example.com", password: "reallyHard2gue$$"}
  # @update_attrs %{email: "william@example.com"}
  @invalid_attrs %{email: nil}

  setup %{conn: conn} do
    with(
      email <- "reg@example.com",
      user  <- add_user_confirmed(email),
      conn  <- conn |> add_token_conn(user)
    ) do
      {:ok, %{conn: conn, user: user}}
    else
      _error ->
        {:ok, %{conn: conn}}
    end
  end


  test "show chosen user's page", %{conn: conn, user: user} do
    conn = post(conn, session_path(conn, :create), session: @create_attrs)
    conn = get(conn, user_path(conn, :show, user))
    assert json_response(conn, 200)["data"] == %{"id" => user.id, "email" => "reg@example.com"}
  end

  test "creates user when data is valid", %{conn: conn} do
    conn = post(conn, user_path(conn, :create), user: %{email: "bill@example.com", password: "reallyHard2gue$$"})
    assert json_response(conn, 200)["data"]["id"]
    assert Accounts.get_by(%{"email" => "bill@example.com"})
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post(conn, user_path(conn, :create), user: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end
end
