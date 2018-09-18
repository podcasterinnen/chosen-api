defmodule :"Elixir.ChosenApi.Repo.Migrations.Drop-tables-tags" do
  use Ecto.Migration

  def change do
    drop table("podcasters_tags")
    drop table("tags")
  end
end
