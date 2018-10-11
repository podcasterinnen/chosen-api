defmodule :"Elixir.ChosenApi.Repo.Migrations.Add-reference-type" do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :references, :map
    end
    drop table("podcasters_podcasts")
    drop table("podcasts")
  end
end
