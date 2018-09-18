defmodule ChosenApi.Repo.Migrations.TagsUpdate2 do
  use Ecto.Migration

  def change do
    alter table(:podcasters_tags) do
      modify :tag_id, references(:tags, on_delete: :delete_all)
    end
  end
end
