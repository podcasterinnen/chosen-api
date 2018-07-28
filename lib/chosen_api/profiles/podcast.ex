defmodule ChosenApi.Profiles.Podcast do
  use Ecto.Schema
  import Ecto.Changeset


  schema "podcasts" do
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(podcast, attrs) do
    podcast
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url])
  end
end
