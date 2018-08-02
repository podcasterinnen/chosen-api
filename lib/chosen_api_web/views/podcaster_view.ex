defmodule ChosenApiWeb.PodcasterView do
  use ChosenApiWeb, :view

  alias ChosenApiWeb.LanguageView
  alias ChosenApiWeb.ReferenceView
  alias ChosenApiWeb.PodcastView
  alias ChosenApiWeb.PodcasterView
  alias ChosenApiWeb.TagView
  alias ChosenApi.Repo

  def render("index.json", %{podcasters: podcasters}) do
    %{data: render_many(podcasters, PodcasterView, "podcaster.json")}
  end

  def render("show.json", %{podcaster: podcaster}) do
    %{data: render_one(podcaster, PodcasterView, "podcaster.json")}
  end

  def render("podcaster.json", %{podcaster: podcaster}) do
    languages = Repo.all(Ecto.assoc(podcaster, :languages))
    references = Repo.all(Ecto.assoc(podcaster, :references))
    podcasts = Repo.all(Ecto.assoc(podcaster, :podcasts))
    tags = Repo.all(Ecto.assoc(podcaster, :tags))
    %{id: podcaster.id,
      forename: podcaster.forename,
      surname: podcaster.surname,
      city: podcaster.city,
      country: podcaster.country,
      website_url: podcaster.website_url,
      twitter_url: podcaster.twitter_url,
      remote_possible: podcaster.remote_possible,
      bio_short: podcaster.bio_short,
      bio_long: podcaster.bio_long,
      references: render_many(references, ReferenceView, "reference.json"),
      tags: render_many(tags, TagView, "tag.json"),
      languages: render_many(languages, LanguageView, "language.json"),
      podcasts: render_many(podcasts, PodcastView, "podcast.json")}
  end
end