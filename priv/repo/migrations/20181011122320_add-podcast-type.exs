defmodule :"Elixir.ChosenApi.Repo.Migrations.Add-podcast-type" do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :podcasts, :map
    end
    drop table("auth_tokens")
  end
end
