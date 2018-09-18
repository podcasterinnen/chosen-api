defmodule ChosenApi.Repo.Migrations.TagsUpdate do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE podcasters_tags DROP CONSTRAINT podcasters_tags_tag_id_fkey"
  end
end
