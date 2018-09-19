defmodule ChosenApi.Profiles do
  @moduledoc """
  The Profiles context.
  """

  import Ecto.Query, warn: false
  alias ChosenApi.Repo
  alias ChosenApi.Profiles.Podcaster

  @doc """
  Returns the list of podcasters.

  ## Examples

      iex> list_podcasters()
      [%Podcaster{}, ...]

  """
  def list_podcasters do
    Repo.all(Podcaster)
    |> Repo.preload([podcasts: (from p in Podcaster)])
    |> Repo.preload(:references)
  end

  @doc """
  Gets a single podcaster.

  Raises `Ecto.NoResultsError` if the Podcaster does not exist.

  ## Examples

      iex> get_podcaster!(123)
      %Podcaster{}

      iex> get_podcaster!(456)
      ** (Ecto.NoResultsError)

  """
  def get_podcaster!(id) do
    Repo.get!(Podcaster, id)
    |> Repo.preload([podcasts: (from p in Podcaster)])
    |> Repo.preload(:references)
  end

  def get_podcaster_by_user_id!(id) do
    Repo.get_by!(Podcaster, user_id: id)
    |> Repo.preload([podcasts: (from p in Podcaster)])
    |> Repo.preload(:references)
  end

  @doc """
  Creates a podcaster.

  ## Examples

      iex> create_podcaster(%{field: value})
      {:ok, %Podcaster{}}

      iex> create_podcaster(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_podcaster(attrs \\ %{}) do
    %Podcaster{}
    |> Repo.preload([podcasts: (from p in Podcaster)])
    |> Repo.preload(:references)
    |> Podcaster.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a podcaster.

  ## Examples

      iex> update_podcaster(podcaster, %{field: new_value})
      {:ok, %Podcaster{}}

      iex> update_podcaster(podcaster, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_podcaster(%Podcaster{} = podcaster, attrs) do
    podcaster
    |> Podcaster.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Podcaster.

  ## Examples

      iex> delete_podcaster(podcaster)
      {:ok, %Podcaster{}}

      iex> delete_podcaster(podcaster)
      {:error, %Ecto.Changeset{}}

  """
  def delete_podcaster(%Podcaster{} = podcaster) do
    Repo.delete(podcaster)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking podcaster changes.

  ## Examples

      iex> change_podcaster(podcaster)
      %Ecto.Changeset{source: %Podcaster{}}

  """
  def change_podcaster(%Podcaster{} = podcaster) do
    Podcaster.changeset(podcaster, %{})
  end

  alias ChosenApi.Profiles.Reference

  @doc """
  Returns the list of references.

  ## Examples

      iex> list_references()
      [%Reference{}, ...]

  """
  def list_references do
    Repo.all(Reference)
  end

  @doc """
  Gets a single reference.

  Raises `Ecto.NoResultsError` if the Reference does not exist.

  ## Examples

      iex> get_reference!(123)
      %Reference{}

      iex> get_reference!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reference!(id), do: Repo.get!(Reference, id)

  @doc """
  Creates a reference.

  ## Examples

      iex> create_reference(%{field: value})
      {:ok, %Reference{}}

      iex> create_reference(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reference(attrs \\ %{}) do
    %Reference{}
    |> Reference.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reference.

  ## Examples

      iex> update_reference(reference, %{field: new_value})
      {:ok, %Reference{}}

      iex> update_reference(reference, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reference(%Reference{} = reference, attrs) do
    reference
    |> Reference.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Reference.

  ## Examples

      iex> delete_reference(reference)
      {:ok, %Reference{}}

      iex> delete_reference(reference)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reference(%Reference{} = reference) do
    Repo.delete(reference)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reference changes.

  ## Examples

      iex> change_reference(reference)
      %Ecto.Changeset{source: %Reference{}}

  """
  def change_reference(%Reference{} = reference) do
    Reference.changeset(reference, %{})
  end

  alias ChosenApi.Profiles.Podcast

  @doc """
  Returns the list of podcasts.

  ## Examples

      iex> list_podcasts()
      [%Podcast{}, ...]

  """
  def list_podcasts do
    Repo.all(Podcast)
  end

  @doc """
  Gets a single podcast.

  Raises `Ecto.NoResultsError` if the Podcast does not exist.

  ## Examples

      iex> get_podcast!(123)
      %Podcast{}

      iex> get_podcast!(456)
      ** (Ecto.NoResultsError)

  """
  def get_podcast!(id), do: Repo.get!(Podcast, id)

  @doc """
  Creates a podcast.

  ## Examples

      iex> create_podcast(%{field: value})
      {:ok, %Podcast{}}

      iex> create_podcast(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_podcast(attrs \\ %{}) do
    %Podcast{}
    |> Podcast.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a podcast.

  ## Examples

      iex> update_podcast(podcast, %{field: new_value})
      {:ok, %Podcast{}}

      iex> update_podcast(podcast, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_podcast(%Podcast{} = podcast, attrs) do
    podcast
    |> Podcast.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Podcast.

  ## Examples

      iex> delete_podcast(podcast)
      {:ok, %Podcast{}}

      iex> delete_podcast(podcast)
      {:error, %Ecto.Changeset{}}

  """
  def delete_podcast(%Podcast{} = podcast) do
    Repo.delete(podcast)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking podcast changes.

  ## Examples

      iex> change_podcast(podcast)
      %Ecto.Changeset{source: %Podcast{}}

  """
  def change_podcast(%Podcast{} = podcast) do
    Podcast.changeset(podcast, %{})
  end
end