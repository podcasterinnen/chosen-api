defmodule ChosenApiWeb.SessionController do
  use ChosenApiWeb, :controller

  import ChosenApiWeb.Authorize
  alias ChosenApi.Accounts
  alias Phauxth.Confirm.Login

  plug(:guest_check when action in [:create])
  plug(:id_check when action in [:delete])

  # If you are using Argon2 or Pbkdf2, add crypto: Comeonin.Argon2
  # or crypto: Comeonin.Pbkdf2 to Login.verify (after Accounts)
  def create(conn, %{"session" => params}) do
    require Logger
    case Login.verify(params, Accounts) do
      {:ok, user} ->
        Logger.debug inspect conn, pretty: true, limit: 30000
        Logger.debug inspect user
        session_id = Login.gen_session_id("F")
        Accounts.add_session(user, session_id, System.system_time(:second))
        message = "You have been logged in. Your User ID is #{user.id}."
        Login.add_session(conn, session_id, user.id)
        |> add_remember_me(user.id, params)
        |> render("info.json", %{info: user.id})
      {:error, message} ->
        error(conn, :unauthorized, 401)
    end
  end

  def delete(%Plug.Conn{assigns: %{current_user: user}} = conn, _) do
    <<session_id::binary-size(17), _::binary>> = get_session(conn, :phauxth_session_id)
    Accounts.delete_session(user, session_id)
    message = "You have been logged out."
    delete_session(conn, :phauxth_session_id)
    |> Phauxth.Remember.delete_rem_cookie()
    |> render("info.json", %{info: message})
  end

  # This function adds a remember_me cookie to the conn.
  # See the documentation for Phauxth.Remember for more details.
  defp add_remember_me(conn, user_id, %{"remember_me" => "true"}) do
    Phauxth.Remember.add_rem_cookie(conn, user_id)
  end

  defp add_remember_me(conn, _, _), do: conn
end
