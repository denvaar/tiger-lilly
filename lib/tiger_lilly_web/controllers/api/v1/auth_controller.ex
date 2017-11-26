defmodule TigerLillyWeb.Api.V1.AuthController do
  use TigerLillyWeb, :controller

  alias TigerLilly.Auth

  def create(conn, %{"email" => email, "password" => password}) do
    case Auth.authenticate(email, password) do
      {:ok, user} ->
        auth_conn = TigerLilly.Guardian.Plug.sign_in(conn, user)
        token = TigerLilly.Guardian.Plug.current_token(auth_conn)
        render(auth_conn, "show.json", token: token)
      {:error, changeset} ->
        render(conn, "show.json", changeset: changeset)
    end
  end
end
