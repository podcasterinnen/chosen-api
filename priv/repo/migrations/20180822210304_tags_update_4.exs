defmodule ChosenApi.Repo.Migrations.TagsUpdate4 do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE podcasters_tags DROP CONSTRAINT podcasters_tags_tag_id_fkey"
    alter table(:podcasters_tags) do
      modify :tag_id, references(:tags, on_replace: :delete, on_delete: :delete_all)
    end
  end
end
