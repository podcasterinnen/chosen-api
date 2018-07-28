defmodule ChosenApi.Repo.Migrations.ReferenceBelongsToPodcaster do
  use Ecto.Migration

  def change do
    alter table(:references) do
      add :podcaster_id, references(:podcasters)
    end
  end
end
