defmodule ChosenApi.Repo.Migrations.AddConfirmedAtAndResetSentToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :confirmed_at, :utc_datetime
      add :reset_sent_at, :utc_datetime
    end
  end
end
