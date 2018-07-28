defmodule ChosenApi.Repo.Migrations.AddSessionToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :sessions, {:map, :integer}, default: %{}
    end
  end
end
