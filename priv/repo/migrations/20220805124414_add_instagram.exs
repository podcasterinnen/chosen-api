defmodule ChosenApi.Repo.Migrations.AddInstagram do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :instagram_url, :text
    end
  end
end
