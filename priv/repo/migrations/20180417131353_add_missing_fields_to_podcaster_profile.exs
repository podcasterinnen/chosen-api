defmodule ChosenApi.Repo.Migrations.AddMissingFieldsToPodcasterProfile do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :twitter_url, :string
      add :remote_possible, :boolean
      add :bio_short, :string
      add :bio_long, :string
    end
  end
end
