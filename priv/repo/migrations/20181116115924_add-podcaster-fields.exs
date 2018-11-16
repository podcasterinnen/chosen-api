defmodule :"Elixir.ChosenApi.Repo.Migrations.Add-podcaster-fields" do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :talks, :boolean
      add :workshops, :boolean
      add :foreign_language, :boolean
      add :record_outside, :boolean
      add :guests, :boolean
      add :travel, :boolean
      add :podcast_production, :boolean
    end
  end
end
