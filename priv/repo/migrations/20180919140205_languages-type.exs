defmodule :"Elixir.ChosenApi.Repo.Migrations.Languages-type" do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :languages, :map
    end
    drop table("podcasters_languages")
    drop table("languages")
  end
end
