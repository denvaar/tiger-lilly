defmodule TigerLilly.Blog.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias TigerLilly.Blog.Tag
  alias TigerLilly.Blog.Post


  schema "tags" do
    field :name, :string

    many_to_many :posts, Post, join_through: "posts_tags"

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
