defmodule TigerLilly.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias TigerLilly.Blog.Post


  schema "posts" do
    field :body, :string
    field :date_published, :utc_datetime
    field :published, :boolean, default: false
    field :summary, :string
    field :title, :string
    field :hero_pattern_style, :string
    field :background_color_class, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:body, :title, :summary, :published, :date_published])
    |> validate_required([:body, :title, :summary, :published, :date_published])
  end

  # def slugified_title(title) do
  #   title
  #    |> String.downcase
  #    |> String.replace(~r/[^a-z0-9\s-]/, "")
  #    |> String.replace(~r/(\s|-)+/, "-")
  #end
end

# defimpl Phoenix.Param, for Blog.Post do
#   def to_param(%{slug: slug, title: title}) do
#     "#{slug}-#{Blog.Post.slugified_title(title)}"
#   end
# end
