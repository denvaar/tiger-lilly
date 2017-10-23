defmodule TigerLilly.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias TigerLilly.Repo

  alias TigerLilly.Blog.Post
  alias TigerLilly.Blog.User
  alias TigerLilly.Auth
  alias TigerLilly.Blog.Tag

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Gets a single post by slug.
  """
  def get_post_by_slug!(slug) do
    Post
    |> Repo.get_by!(slug: slug)
    |> Repo.preload(:tags)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Repo.preload(:tags)
    |> Post.changeset(attrs)
    |> put_tags_post(attrs)
    |> Repo.insert()
  end

  def put_tags_post(changeset, attrs) do
    ids = tag_ids_from(attrs)
    tags = Repo.all(from(t in Tag, where: t.id in ^ids))
    Ecto.Changeset.put_assoc(changeset, :tags, tags)
  end

  defp tag_ids_from(attrs) do
    attrs
    |> Map.get("tags", [])
    |> Enum.map(fn id -> String.to_integer(id) end)
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Repo.preload(:tags)
    |> Post.changeset(attrs)
    |> put_tags_post(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  def create_user(attrs \\ %{}) do
    {password, attrs} = Map.pop(attrs, :password)

    %User{}
    |> User.changeset(Map.put_new(attrs, :password_hash, Auth.make_hash(password)))
    |> Repo.insert()
  end

  def get_user!(id), do: Repo.get!(User, id)

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user_by_email(email) do
    Repo.get_by(User, email: String.downcase(email))
  end


  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}

  """
  def change_tag(%Tag{} = tag) do
    Tag.changeset(tag, %{})
  end
end
