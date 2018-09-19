defmodule ChosenApi.Profiles.Podcaster do

  defmodule LanguageType do
    @behaviour Ecto.Type
    def type, do: :map
    def cast(languages) when is_list(languages) do
      # Todo: Ecto Validation
      # Todo: languages in downcase
      {:ok, Enum.uniq(languages)}
    end
    def cast(_), do: :error
    def load(%{"languages" => languages}) do
      {:ok, languages}
    end
    def dump(languages) when is_list(languages) do
      {:ok, %{languages: languages}}
    end
    def dump(_), do: :error
  end  

  defmodule TagType do
    @behaviour Ecto.Type
    def type, do: :map
    def cast(tags) when is_list(tags) do
      # Todo: Ecto Validation
      # Todo: Tags in downcase
      {:ok, Enum.uniq(tags)}
    end
    def cast(_), do: :error
    def load(%{"tags" => tags}) do
      {:ok, tags}
    end
    def dump(tags) when is_list(tags) do
      {:ok, %{tags: tags}}
    end
    def dump(_), do: :error
  end  

  use Ecto.Schema

  import Ecto.Changeset

  alias ChosenApi.Profiles.Reference
  alias ChosenApi.Profiles.Podcast
  alias ChosenApi.Accounts.User

  require Logger

  schema "podcasters" do
    field :forename, :string
    field :surname, :string
    field :city, :string
    field :country, :string
    field :website_url, :string
    field :twitter_url, :string
    field :remote_possible, :boolean
    field :bio_short, :string
    field :bio_long, :string
    field :languages, LanguageType
    field :tags, TagType
    many_to_many :podcasts, Podcast, join_through: "podcasters_podcasts"
    has_many :references, Reference, [foreign_key: :podcaster_id, on_replace: :delete]
    belongs_to :user, User, references: :id

    timestamps()
  end

  @doc false
  def changeset(podcaster, attrs) do
    podcaster
    |> cast(attrs, [:forename, :surname, :city, :country, :website_url, :twitter_url, :remote_possible, :bio_short, :bio_long, :tags, :languages])
    |> validate_required([:forename])
    |> cast_assoc(:references)
    |> cast_assoc(:podcasts)
  end
end
