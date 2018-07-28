defmodule ChosenApi.Repo.Migrations.CreatePodcastersTags do
  use Ecto.Migration

  def change do
    create table(:podcasters_tags) do
      add :tag_id, references(:tags)
      add :podcaster_id, references(:podcasters)
    end

    create unique_index(:podcasters_tags, [:tag_id, :podcaster_id])
  end
end
