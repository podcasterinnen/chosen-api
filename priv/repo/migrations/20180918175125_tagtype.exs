defmodule ChosenApi.Repo.Migrations.Tagtype do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :tags, :map
    end
  end
end
