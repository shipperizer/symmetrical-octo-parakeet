defmodule Admin.Router do
  use Admin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: Admin.Token
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/admin", Admin do
    pipe_through :browser

    get "/", HomepageController, :index
    resources "/auth", AuthController, only: [:create, :delete]
  end

  scope "/admin", Admin do
    pipe_through [:browser, :auth]

    resources "/users", UserController
    resources "/videos", VideoController
  end

  scope "/api" do
    forward "/graphql", Absinthe.Plug,
      schema: Admin.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", Admin do
  #   pipe_through :api
  # end
end
