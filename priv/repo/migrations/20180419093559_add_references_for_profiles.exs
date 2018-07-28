defmodule ChosenApi.Repo.Migrations.AddReferencesForProfiles do
  use Ecto.Migration

  def change do
    create table(:references) do
      add :title, :string
      add :url, :string

      timestamps()
    end
  end
end
