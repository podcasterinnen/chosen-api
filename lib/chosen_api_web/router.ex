defmodule ChosenApiWeb.Router do
  use ChosenApiWeb, :router

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:8080"]
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug Phauxth.Authenticate
    plug Phauxth.Remember
  end

  scope "/", ChosenApiWeb do
    pipe_through :api
    resources "/podcasters", PodcasterController, only: [:show, :index]
    resources "/languages", LanguageController, only: [:show, :index]
    resources "/references", ReferenceController, only: [:show, :index]
    resources "/podcasts", PodcastController, only: [:show, :index]
    resources "/tags", TagController, only: [:show, :index]
    get "/confirm", ConfirmController, :index
    post "/password_resets", PasswordResetController, :create
    put "/password_resets/update", PasswordResetController, :update
    put "/podcasters/:id", PodcasterController, :update
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    post "/users", UserController, :create
    get "/users", UserController, :index
    get "/users", UserController, :show
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

end
