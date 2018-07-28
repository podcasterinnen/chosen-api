defmodule ChosenApi.Profiles.Reference do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChosenApi.Profiles.Podcaster

  schema "references" do
    field :title, :string
    field :url, :string
    belongs_to :podcaster, Podcaster, references: :id

    timestamps()
  end

  @doc false
  def changeset(reference, attrs) do
    reference
    |> cast(attrs, [:title, :url])
    |> validate_required([:title, :url])
  end
end
