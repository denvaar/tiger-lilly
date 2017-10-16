defmodule TigerLilly.Blog.User do
  use Ecto.Schema

  import Ecto.Changeset
  alias TigerLilly.Blog.User


  schema "users" do

    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password_hash])
    |> unique_constraint(:email)
    |> validate_required([:email, :password_hash])
  end
end
