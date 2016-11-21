defmodule Todos.Router do
  use Todos.Web, :router

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

  scope "/api", Todos do
    pipe_through :api

    resources "/todos", TodoController, only: [:index, :show, :create]
  end
  # Other scopes may use custom stacks.
  # scope "/api", Todos do
  #   pipe_through :api
  # end
end
