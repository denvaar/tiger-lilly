defmodule TigerLillyWeb.Api.V1.AuthView do
  use TigerLillyWeb, :view

  def render("show.json", %{token: token}) do
    %{access_token: token}
  end

  def render("show.json", %{changeset: _changeset}) do
    %{errors: "invalid credentials"}
  end
end
