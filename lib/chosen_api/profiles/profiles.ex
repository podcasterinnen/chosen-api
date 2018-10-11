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
  end

  def get_podcaster_by_user_id!(id) do
    Repo.get_by!(Podcaster, user_id: id)
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
end