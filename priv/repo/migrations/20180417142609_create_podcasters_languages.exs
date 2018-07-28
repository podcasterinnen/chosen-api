defmodule ChosenApi.Repo.Migrations.CreatePodcastersLanguages do
  use Ecto.Migration

  def change do
    create table(:podcasters_languages) do
      add :language_id, references(:languages)
      add :podcaster_id, references(:podcasters)
    end

    create unique_index(:podcasters_languages, [:language_id, :podcaster_id])
  end
end
