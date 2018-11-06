defmodule ChosenApi.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :confirmed_at, :utc_datetime
      add :reset_sent_at, :utc_datetime
      add :sessions, {:map, :integer}, default: "{}"
      timestamps()
    end
    
    create table(:podcasters) do
      add :forename, :text
      add :surname, :text
      add :website_url, :text
      add :twitter_url, :text
      add :remote_possible, :boolean
      add :bio_short, :string
      add :bio_long, :string
      add :city, :string
      add :country, :string
      add :tags, :map
      add :languages, :map
      add :podcasts, :map
      add :references, :map
      add :user_id, references(:users)
      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
