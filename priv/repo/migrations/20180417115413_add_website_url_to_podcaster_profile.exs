defmodule ChosenApi.Repo.Migrations.AddWebsiteUrlToPodcasterProfile do
  use Ecto.Migration

  def change do
    alter table(:podcasters) do
      add :website_url, :string
    end
  end
end
