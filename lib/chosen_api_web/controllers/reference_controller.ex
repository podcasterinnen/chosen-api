defmodule ChosenApiWeb.ReferenceController do
  use ChosenApiWeb, :controller

  alias ChosenApi.Profiles
  alias ChosenApi.Profiles.Reference

  action_fallback ChosenApiWeb.FallbackController

  def index(conn, _params) do
    references = Profiles.list_references()
    render(conn, "index.json", references: references)
  end

  def create(conn, %{"reference" => reference_params}) do
    with {:ok, %Reference{} = reference} <- Profiles.create_reference(reference_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", reference_path(conn, :show, reference))
      |> render("show.json", reference: reference)
    end
  end

  def show(conn, %{"id" => id}) do
    reference = Profiles.get_reference!(id)
    render(conn, "show.json", reference: reference)
  end

  def update(conn, %{"id" => id, "reference" => reference_params}) do
    reference = Profiles.get_reference!(id)

    with {:ok, %Reference{} = reference} <- Profiles.update_reference(reference, reference_params) do
      render(conn, "show.json", reference: reference)
    end
  end

  def delete(conn, %{"id" => id}) do
    reference = Profiles.get_reference!(id)
    with {:ok, %Reference{}} <- Profiles.delete_reference(reference) do
      send_resp(conn, :no_content, "")
    end
  end
end
