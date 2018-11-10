defmodule PeopleWeb.Router do
  use PeopleWeb, :router

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

  scope "/", PeopleWeb do
    pipe_through :browser

    get "/", UserController, :index
    get "/:id", UserController, :show
    get "/create", UserController, :new
    post "/create", UserController, :create
    get "/edit/:id", UserController, :edit
    post "/edit/:id", UserController, :update
  end
end
