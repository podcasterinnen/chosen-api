defmodule ChosenApi.Repo.Migrations.CreatePodcastersPocasts do
  use Ecto.Migration

  def change do
    create table(:podcasters_podcasts) do
      add :podcast_id, references(:podcasts)
      add :podcaster_id, references(:podcasters)
    end

    create unique_index(:podcasters_podcasts, [:podcast_id, :podcaster_id])
  end
end
