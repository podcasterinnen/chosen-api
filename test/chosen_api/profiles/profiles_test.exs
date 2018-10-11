defmodule ChosenApi.ProfilesTest do
  use ChosenApi.DataCase

  alias ChosenApi.Profiles

  describe "podcasters" do
    alias ChosenApi.Profiles.Podcaster

    @valid_attrs %{forename: "some forename", surname: "some surname"}
    @update_attrs %{forename: "some updated forename", surname: "some updated surname"}
    @invalid_attrs %{forename: nil, surname: nil}

    def podcaster_fixture(attrs \\ %{}) do
      {:ok, podcaster} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profiles.create_podcaster()

      podcaster
    end

    test "list_podcasters/0 returns all podcasters" do
      podcaster = podcaster_fixture()
      assert Profiles.list_podcasters() == [podcaster]
    end

    test "get_podcaster!/1 returns the podcaster with given id" do
      podcaster = podcaster_fixture()
      assert Profiles.get_podcaster!(podcaster.id) == podcaster
    end

    test "create_podcaster/1 with valid data creates a podcaster" do
      assert {:ok, %Podcaster{} = podcaster} = Profiles.create_podcaster(@valid_attrs)
      assert podcaster.forename == "some forename"
      assert podcaster.surname == "some surname"
    end

    test "create_podcaster/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_podcaster(@invalid_attrs)
    end

    test "update_podcaster/2 with valid data updates the podcaster" do
      podcaster = podcaster_fixture()
      assert {:ok, podcaster} = Profiles.update_podcaster(podcaster, @update_attrs)
      assert %Podcaster{} = podcaster
      assert podcaster.forename == "some updated forename"
      assert podcaster.surname == "some updated surname"
    end

    test "update_podcaster/2 with invalid data returns error changeset" do
      podcaster = podcaster_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_podcaster(podcaster, @invalid_attrs)
      assert podcaster == Profiles.get_podcaster!(podcaster.id)
    end

    test "delete_podcaster/1 deletes the podcaster" do
      podcaster = podcaster_fixture()
      assert {:ok, %Podcaster{}} = Profiles.delete_podcaster(podcaster)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_podcaster!(podcaster.id) end
    end

    test "change_podcaster/1 returns a podcaster changeset" do
      podcaster = podcaster_fixture()
      assert %Ecto.Changeset{} = Profiles.change_podcaster(podcaster)
    end
  end
end