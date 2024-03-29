defmodule ChosenApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChosenApi.Accounts.User
  alias ChosenApi.Profiles.Podcaster

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :confirmed_at, :utc_datetime_usec
    field :reset_sent_at, :utc_datetime_usec
    has_one :podcasters, Podcaster, foreign_key: :user_id
    field(:sessions, {:map, :integer}, default: %{})

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_email
  end

  def create_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> cast_assoc(:podcasters)
    |> validate_required([:email, :password])
    |> unique_email
    |> validate_password(:password)
    |> put_pass_hash
  end

  defp unique_email(changeset) do
    validate_format(changeset, :email, ~r/@/)
    |> validate_length(:email, max: 254)
    |> unique_constraint(:email)
  end

  # In the function below, strong_password? just checks that the password
  # is at least 8 characters long.
  # See the documentation for NotQwerty123.PasswordStrength.strong_password?
  # for a more comprehensive password strength checker.
  defp validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, password ->
      case strong_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  # If you are using Argon2 or Pbkdf2, change Bcrypt to Argon2 or Pbkdf2
  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes:
      %{password: password}} = changeset) do
    change(changeset, Comeonin.Bcrypt.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset

  defp strong_password?(password) when byte_size(password) > 11 do
    {:ok, password}
  end

  defp strong_password?(_), do: {:error, "The password is too short"}
end
