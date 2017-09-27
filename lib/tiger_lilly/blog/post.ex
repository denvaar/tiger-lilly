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

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:body, :title, :summary, :published, :date_published])
    |> validate_required([:body, :title, :summary, :published, :date_published])
  end
end
