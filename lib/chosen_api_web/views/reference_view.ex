defmodule ChosenApiWeb.ReferenceView do
  use ChosenApiWeb, :view
  alias ChosenApiWeb.ReferenceView

  def render("index.json", %{references: references}) do
    %{data: render_many(references, ReferenceView, "reference.json")}
  end

  def render("show.json", %{reference: reference}) do
    %{data: render_one(reference, ReferenceView, "reference.json")}
  end

  def render("reference.json", %{reference: reference}) do
    %{id: reference.id,
      title: reference.title,
      url: reference.url}
  end
end
