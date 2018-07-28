defmodule ChosenApiWeb.ConfirmView do
  use ChosenApiWeb, :view

  def render("info.json", %{info: message}) do
    %{info: %{detail: message}}
  end
end
