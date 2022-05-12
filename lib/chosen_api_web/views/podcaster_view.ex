defmodule ChosenApiWeb.PodcasterView do
  use ChosenApiWeb, :view

  alias ChosenApiWeb.PodcasterView

  def render("index.json", %{podcasters: podcasters}) do
    %{data: render_many(podcasters, PodcasterView, "podcaster.json")}
  end

  def render("show.json", %{podcaster: podcaster}) do
    %{data: render_one(podcaster, PodcasterView, "podcaster.json")}
  end

  def render("podcaster.json", %{podcaster: podcaster}) do
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
      references: podcaster.references,
      tags: podcaster.tags,
      languages: podcaster.languages,
      podcasts: podcaster.podcasts,
      pronouns: podcaster.pronouns,
      profile_state: podcaster.profile_state,
      talks: podcaster.talks,
      workshops: podcaster.workshops,
      foreign_language: podcaster.foreign_language,
      record_outside: podcaster.record_outside,
      guests: podcaster.guests,
      travel: podcaster.travel,
      podcast_production: podcaster.podcast_production,
      avatar: public_avatar_url(ChosenApi.Avatar.url({podcaster.avatar, podcaster}, :original)),
      date_created: podcaster.inserted_at
    }
  end

  def public_avatar_url(nil) do
    nil
  end
  def public_avatar_url(url) do
    with(
      {:ok, _} <- System.fetch_env("UPLOAD_DIR")
    ) do
      Regex.replace(~r/^\/.+(\/uploads.+)$/, url, "\\1")
    else
      _ ->
        url
    end
  end
end
