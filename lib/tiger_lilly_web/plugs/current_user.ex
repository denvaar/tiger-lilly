defmodule TigerLilly.CurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = TigerLilly.Guardian.Plug.current_resource(conn)
    assign(conn, :current_user, current_user)
  end
end
