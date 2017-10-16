defmodule TigerLillyWeb.ErrorView do
  use TigerLillyWeb, :view

  def render("404.html", assigns) do
    render("404_page.html", assigns)
  end

  def render("401.html", assigns) do
    render("401_page.html", assigns)
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
