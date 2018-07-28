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

  describe "languages" do
    alias ChosenApi.Profiles.Language

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def language_fixture(attrs \\ %{}) do
      {:ok, language} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profiles.create_language()

      language
    end

    test "list_languages/0 returns all languages" do
      language = language_fixture()
      assert Profiles.list_languages() == [language]
    end

    test "get_language!/1 returns the language with given id" do
      language = language_fixture()
      assert Profiles.get_language!(language.id) == language
    end

    test "create_language/1 with valid data creates a language" do
      assert {:ok, %Language{} = language} = Profiles.create_language(@valid_attrs)
      assert language.name == "some name"
    end

    test "create_language/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_language(@invalid_attrs)
    end

    test "update_language/2 with valid data updates the language" do
      language = language_fixture()
      assert {:ok, language} = Profiles.update_language(language, @update_attrs)
      assert %Language{} = language
      assert language.name == "some updated name"
    end

    test "update_language/2 with invalid data returns error changeset" do
      language = language_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_language(language, @invalid_attrs)
      assert language == Profiles.get_language!(language.id)
    end

    test "delete_language/1 deletes the language" do
      language = language_fixture()
      assert {:ok, %Language{}} = Profiles.delete_language(language)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_language!(language.id) end
    end

    test "change_language/1 returns a language changeset" do
      language = language_fixture()
      assert %Ecto.Changeset{} = Profiles.change_language(language)
    end
  end

  describe "references" do
    alias ChosenApi.Profiles.Reference

    @valid_attrs %{title: "some title", url: "some url"}
    @update_attrs %{title: "some updated title", url: "some updated url"}
    @invalid_attrs %{title: nil, url: nil}

    def reference_fixture(attrs \\ %{}) do
      {:ok, reference} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profiles.create_reference()

      reference
    end

    test "list_references/0 returns all references" do
      reference = reference_fixture()
      assert Profiles.list_references() == [reference]
    end

    test "get_reference!/1 returns the reference with given id" do
      reference = reference_fixture()
      assert Profiles.get_reference!(reference.id) == reference
    end

    test "create_reference/1 with valid data creates a reference" do
      assert {:ok, %Reference{} = reference} = Profiles.create_reference(@valid_attrs)
      assert reference.title == "some title"
      assert reference.url == "some url"
    end

    test "create_reference/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_reference(@invalid_attrs)
    end

    test "update_reference/2 with valid data updates the reference" do
      reference = reference_fixture()
      assert {:ok, reference} = Profiles.update_reference(reference, @update_attrs)
      assert %Reference{} = reference
      assert reference.title == "some updated title"
      assert reference.url == "some updated url"
    end

    test "update_reference/2 with invalid data returns error changeset" do
      reference = reference_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_reference(reference, @invalid_attrs)
      assert reference == Profiles.get_reference!(reference.id)
    end

    test "delete_reference/1 deletes the reference" do
      reference = reference_fixture()
      assert {:ok, %Reference{}} = Profiles.delete_reference(reference)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_reference!(reference.id) end
    end

    test "change_reference/1 returns a reference changeset" do
      reference = reference_fixture()
      assert %Ecto.Changeset{} = Profiles.change_reference(reference)
    end
  end

  describe "podcasts" do
    alias ChosenApi.Profiles.Podcast

    @valid_attrs %{title: "some title", url: "some url"}
    @update_attrs %{title: "some updated title", url: "some updated url"}
    @invalid_attrs %{title: nil, url: nil}

    def podcast_fixture(attrs \\ %{}) do
      {:ok, podcast} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profiles.create_podcast()

      podcast
    end

    test "list_podcasts/0 returns all podcasts" do
      podcast = podcast_fixture()
      assert Profiles.list_podcasts() == [podcast]
    end

    test "get_podcast!/1 returns the podcast with given id" do
      podcast = podcast_fixture()
      assert Profiles.get_podcast!(podcast.id) == podcast
    end

    test "create_podcast/1 with valid data creates a podcast" do
      assert {:ok, %Podcast{} = podcast} = Profiles.create_podcast(@valid_attrs)
      assert podcast.title == "some title"
      assert podcast.url == "some url"
    end

    test "create_podcast/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_podcast(@invalid_attrs)
    end

    test "update_podcast/2 with valid data updates the podcast" do
      podcast = podcast_fixture()
      assert {:ok, podcast} = Profiles.update_podcast(podcast, @update_attrs)
      assert %Podcast{} = podcast
      assert podcast.title == "some updated title"
      assert podcast.url == "some updated url"
    end

    test "update_podcast/2 with invalid data returns error changeset" do
      podcast = podcast_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_podcast(podcast, @invalid_attrs)
      assert podcast == Profiles.get_podcast!(podcast.id)
    end

    test "delete_podcast/1 deletes the podcast" do
      podcast = podcast_fixture()
      assert {:ok, %Podcast{}} = Profiles.delete_podcast(podcast)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_podcast!(podcast.id) end
    end

    test "change_podcast/1 returns a podcast changeset" do
      podcast = podcast_fixture()
      assert %Ecto.Changeset{} = Profiles.change_podcast(podcast)
    end
  end

  describe "tags" do
    alias ChosenApi.Profiles.Tag

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Profiles.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Profiles.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Profiles.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Profiles.create_tag(@valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, tag} = Profiles.update_tag(tag, @update_attrs)
      assert %Tag{} = tag
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_tag(tag, @invalid_attrs)
      assert tag == Profiles.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Profiles.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Profiles.change_tag(tag)
    end
  end
end
