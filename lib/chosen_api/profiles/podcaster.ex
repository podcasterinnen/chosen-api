defmodule ChosenApi.Profiles.Podcaster do
  defmodule TagType do
    @behaviour Ecto.Type
    def type, do: :map
  
    def cast(tags) when is_list(tags) do
      # Ecto Validation
      # Tags in downcase
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
  import Ecto.Query

  alias ChosenApi.Repo
  alias ChosenApi.Profiles.Language
  alias ChosenApi.Profiles.Reference
  alias ChosenApi.Profiles.Podcast
  alias ChosenApi.Profiles.Tag
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
    many_to_many :languages, Language, join_through: "podcasters_languages"
    field :tags, TagType
    many_to_many :podcasts, Podcast, join_through: "podcasters_podcasts"
    has_many :references, Reference, foreign_key: :podcaster_id
    belongs_to :user, User, references: :id

    timestamps()
  end

  @doc false
  def changeset(podcaster, attrs) do
    podcaster
    |> cast(attrs, [:forename, :surname, :city, :country, :website_url, :twitter_url, :remote_possible, :bio_short, :bio_long, :tags])
    |> validate_required([:forename])
    |> cast_assoc(:references)
    |> cast_assoc(:podcasts, on_replace: :update)
    |> put_assoc(:languages, parse_languages(attrs))
  end

  defp parse_languages(attrs) do
    Logger.info "Var value: #{inspect(attrs["languages"])}"
    (attrs["languages"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> insert_and_get_all_languages()
  end

  defp insert_and_get_all_languages([]) do
    []
  end

  defp insert_and_get_all_languages(names) do
    maps = Enum.map(names, &%{name: &1})
    Repo.insert_all Language, maps, on_conflict: :replace_all, conflict_target: :name, on_replace: :delete
    Repo.all(from t in Language, where: t.name in ^names)
  end
end
