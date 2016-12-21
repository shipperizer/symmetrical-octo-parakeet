defmodule Admin.Router do
  use Admin.Web, :router

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

  scope "/admin", Admin do
    pipe_through :browser

    resources "/users", UserController

  end

  # Other scopes may use custom stacks.
  # scope "/api", Admin do
  #   pipe_through :api
  # end
end
