defmodule ChosenApi.Repo.Migrations.TagsUpdate5 do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE podcasters_tags DROP CONSTRAINT podcasters_tags_tag_id_fkey"
    alter table(:podcasters_tags) do
      modify :tag_id, references(:tags, on_replace: :delete, on_delete: :nothing)
    end
  end
end
