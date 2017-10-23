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

    resources "/", PostController, except: [:show, :index]
    resources "/tags", TagController
  end

  scope "/", TigerLillyWeb do
    pipe_through [:browser]

    resources "/", PostController, only: [:show, :index]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
