defmodule ChosenApi.Repo.Migrations.AddPronouns do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :pronouns, :map
    end
  end
end
