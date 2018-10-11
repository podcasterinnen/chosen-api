defmodule :"Elixir.ChosenApi.Repo.Migrations.Remove-reference-tables" do
  use Ecto.Migration

  def change do
    drop table("references")
  end
end
