defmodule :"Elixir.ChosenApi.Repo.Migrations.Add-avatar-to-podcaster" do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :avatar, :string
    end
  end
end
