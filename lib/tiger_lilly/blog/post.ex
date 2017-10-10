defmodule TigerLilly.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias TigerLilly.Blog.Post


  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :body, :string
    field :date_published, :utc_datetime
    field :published, :boolean, default: false
    field :summary, :string
    field :title, :string
    field :hero_pattern_style, :string
    field :background_color_class, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    attrs = Map.merge(attrs, slug_map(attrs))

    post
    |> cast(attrs, [:slug, :body, :title, :summary, :published, :date_published])
    |> validate_required([:body, :title, :summary, :published, :date_published])
  end

  defp slug_map(%{"title" => title}) do
    slug = String.downcase(title) |> String.replace(" ", "-")
    %{"slug" => slug}
  end
  defp slug_map(_params) do
    %{}
  end
end
