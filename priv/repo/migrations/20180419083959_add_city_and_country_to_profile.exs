defmodule ChosenApi.Repo.Migrations.AddCityAndCountryToProfile do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :city, :string
      add :country, :string
    end
  end
end
