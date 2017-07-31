defmodule Datalocker.Router do
  use Datalocker.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Datalocker do
    pipe_through :browser # Use the default browser stack

    resources "/", LockerController do
      resources "/items", ItemController
    end
    post "/evaluate_link", LockerController, :evaluate_link
  end

  # Other scopes may use custom stacks.
  # scope "/api", Datalocker do
  #   pipe_through :api
  # end
end
