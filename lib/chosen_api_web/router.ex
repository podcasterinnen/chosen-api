defmodule ChosenApiWeb.Router do
  use ChosenApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug Phauxth.Authenticate
    plug Phauxth.Remember
  end

  scope "/", ChosenApiWeb do
    pipe_through :api
    resources     "/podcasters",             PodcasterController, only: [:show, :index]
    get           "/confirm",                ConfirmController, :index
    post          "/password_resets",        PasswordResetController, :create
    put           "/password_resets/update", PasswordResetController, :update
    put           "/podcasters/:id",         PodcasterController, :update
    resources     "/sessions",               SessionController, only: [:new, :create, :delete]
    post          "/users",                  UserController, :create
    get           "/users/:id",              UserController, :show
  end

  if Mix.env == :dev do
    forward "/mailbox", Plug.Swoosh.MailboxPreview
  end

end
