defmodule TigerLillyWeb.SessionController do
  use TigerLillyWeb, :controller

  alias TigerLilly.Blog
  alias TigerLilly.Blog.User
  alias TigerLilly.Auth

  def new(conn, _params) do
    changeset = Blog.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Auth.authenticate(email, password) do
      {:ok, user} ->
        auth_conn = TigerLilly.Guardian.Plug.sign_in(conn, user)
        auth_conn
        |> put_flash(:info, "Sign in successful.")
        |> redirect(to: post_path(auth_conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Invalid sign in.")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    unauth_conn = TigerLilly.Guardian.Plug.sign_out(conn)

    unauth_conn
    |> put_flash(:info, "You have signed out.")
    |> redirect(to: post_path(unauth_conn, :index))
  end
end
