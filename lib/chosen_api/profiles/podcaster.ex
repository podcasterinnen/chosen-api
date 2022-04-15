defmodule ChosenApi.Profiles.Podcaster do

  defmodule LanguageType do
    use Ecto.Type
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
    use Ecto.Type
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

  defmodule PodcastType do
    use Ecto.Type
    def type, do: :map
    def cast(podcasts) when is_list(podcasts) do
      # Todo: Ecto Validation
      # Todo: podcasts in downcase
      {:ok, Enum.uniq(podcasts)}
    end
    def cast(_), do: :error
    def load(%{"podcasts" => podcasts}) do
      {:ok, podcasts}
    end
    def dump(podcasts) when is_list(podcasts) do
      {:ok, %{podcasts: podcasts}}
    end
    def dump(_), do: :error
  end

  defmodule ReferenceType do
    use Ecto.Type
    def type, do: :map
    def cast(references) when is_list(references) do
      # Todo: Ecto Validation
      # Todo: references in downcase
      {:ok, Enum.uniq(references)}
    end
    def cast(_), do: :error
    def load(%{"references" => references}) do
      {:ok, references}
    end
    def dump(references) when is_list(references) do
      {:ok, %{references: references}}
    end
    def dump(_), do: :error
  end

  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
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
    field :podcasts, PodcastType
    field :references, ReferenceType
    field :profile_state, :string
    field :talks, :boolean
    field :workshops, :boolean
    field :foreign_language, :boolean
    field :record_outside, :boolean
    field :guests, :boolean
    field :travel, :boolean
    field :podcast_production, :boolean
    field :avatar, ChosenApi.Avatar.Type
    belongs_to :user, User, references: :id

    timestamps()
  end

  @doc false
  def changeset(podcaster, attrs) do
    podcaster
    |> cast(attrs, [:forename, :surname, :city, :country, :website_url, :twitter_url, :remote_possible, :bio_short, :bio_long, :tags, :languages, :podcasts, :references, :profile_state, :talks, :workshops, :foreign_language, :record_outside, :guests, :travel, :podcast_production, :user_id])
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:forename])
  end
end
