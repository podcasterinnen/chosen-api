defmodule ChosenApiWeb.SessionControllerTest do
  use ChosenApiWeb.ConnCase

  import ChosenApiWeb.AuthCase

  @create_attrs %{email: "robin@example.com", password: "reallyHard2gue$$"}
  @invalid_attrs %{email: "robin@example.com", password: "cannotGue$$it"}
  @unconfirmed_attrs %{email: "lancelot@example.com", password: "reallyHard2gue$$"}

  setup %{conn: conn} do
    add_user("lancelot@example.com")
    user = add_user_confirmed("robin@example.com")
    {:ok, %{conn: conn, user: user}}
  end

  test "login succeeds", %{conn: conn} do
    conn = post(conn, session_path(conn, :create), session: @create_attrs)
    assert json_response(conn, 200)

    [cookie] = get_resp_header(conn, "set-cookie")
    assert false == is_nil(cookie)
  end

  test "login fails for user that is not yet confirmed", %{conn: conn} do
    conn = post(conn, session_path(conn, :create), session: @unconfirmed_attrs)
    assert json_response(conn, 401)["errors"]["detail"] =~ "need to login"
  end

  test "login fails for invalid password", %{conn: conn} do
    conn = post(conn, session_path(conn, :create), session: @invalid_attrs)
    assert json_response(conn, 401)["errors"]["detail"] =~ "need to login"
  end
end
