defmodule TigerLillyWeb.PageController do
  use TigerLillyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
