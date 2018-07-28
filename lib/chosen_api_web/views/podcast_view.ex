defmodule ChosenApiWeb.PodcastView do
  use ChosenApiWeb, :view
  alias ChosenApiWeb.PodcastView

  def render("index.json", %{podcasts: podcasts}) do
    %{data: render_many(podcasts, PodcastView, "podcast.json")}
  end

  def render("show.json", %{podcast: podcast}) do
    %{data: render_one(podcast, PodcastView, "podcast.json")}
  end

  def render("podcast.json", %{podcast: podcast}) do
    %{id: podcast.id,
      name: podcast.name,
      url: podcast.url}
  end
end
