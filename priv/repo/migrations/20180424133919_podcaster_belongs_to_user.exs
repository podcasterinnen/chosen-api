defmodule ChosenApi.Repo.Migrations.PodcasterBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :user_id, references(:users)
    end
  end
end
