defmodule ChosenApi.Repo.Migrations.CreatePodcasters do
  use Ecto.Migration

  def change do
    create table(:podcasters) do
      add :forename, :text
      add :surname, :text

      timestamps()
    end

  end
end
