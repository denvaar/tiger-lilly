defmodule TigerLillyWeb.Router do
  use TigerLillyWeb, :router

  pipeline :browser_auth do
    plug TigerLilly.Guardian.EnsureAuthenticated
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TigerLilly.Guardian.BrowserAuthPipeline
  end

  scope "/", TigerLillyWeb do
    pipe_through [:browser, :browser_auth]

    resources "/articles", PostController, except: [:show, :index]
    resources "/tags", TagController
    resources "/tils", NuggetController, except: [:show, :index]
  end

  scope "/", TigerLillyWeb do
    pipe_through [:browser]

    get "/", PostController, :index # TODO redirect_to instead
    resources "/articles", PostController, only: [:show, :index]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/tils", NuggetController, only: [:show, :index]
  end
end
