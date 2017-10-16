defmodule TigerLilly.AuthErrorHandler do
  import Plug.Conn
  import Phoenix.Controller, only: [render: 4]

  def auth_error(conn, {_type, reason}, _opts) do
    conn
    |> put_status(401)
    |> render(TigerLillyWeb.ErrorView, :"401", message: "#{reason}")
  end
end
