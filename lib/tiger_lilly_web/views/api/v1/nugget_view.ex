defmodule TigerLillyWeb.Api.V1.NuggetView do
  use TigerLillyWeb, :view

  def render("show.json", %{nugget: nugget, conn: conn}) do
    %{data: render_one(nugget, TigerLillyWeb.Api.V1.NuggetView, "nugget.json"),
      resource_path: nugget_path(conn, :show, nugget.id)}
  end

  def render("nugget.json", %{nugget: nugget}) do
    %{id: nugget.id,
      description: nugget.description,
      date: nugget.date,
      tags: render_many(nugget.tags,
                        TigerLillyWeb.Api.V1.NuggetView,
                        "tag.json",
                        as: :tag)}
  end

  def render("tag.json", %{tag: tag}) do
    %{name: tag.name}
  end
end
