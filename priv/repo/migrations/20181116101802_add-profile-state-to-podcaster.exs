defmodule :"Elixir.ChosenApi.Repo.Migrations.Add-profile-state-to-podcaster" do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :profile_state, :string
    end
  end
end
