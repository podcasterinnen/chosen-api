defmodule ChosenApi.Repo.Migrations.CreateLanguage do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :name, :string

      timestamps()
    end

    create unique_index(:languages, [:name])
  end
end
