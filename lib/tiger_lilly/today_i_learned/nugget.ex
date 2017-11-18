defmodule TigerLilly.TodayILearned.Nugget do
  use Ecto.Schema
  import Ecto.Changeset
  alias TigerLilly.TodayILearned.Nugget
  alias TigerLilly.Blog.Tag


  schema "nuggetes" do
    field :date, :utc_datetime
    field :description, :string

    many_to_many :tags, Tag, join_through: "nuggetes_tags", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Nugget{} = nugget, attrs) do
    nugget
    |> cast(attrs, [:date, :description])
    |> validate_required([:date, :description])
  end
end
