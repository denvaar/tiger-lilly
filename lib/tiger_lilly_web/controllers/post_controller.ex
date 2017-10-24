defmodule TigerLillyWeb.PostController do
  use TigerLillyWeb, :controller

  import TigerLilly.PostTagUtils

  alias TigerLilly.Repo
  alias TigerLilly.Blog
  alias TigerLilly.Blog.Post

  plug :assign_available_tags when action in [:new, :create, :edit, :update]

  def index(conn, params) do
    page =
      Blog.list_posts_as_query()
      |> Blog.order_by_published_date()
      |> Repo.paginate(params)
    render(conn, "index.html", posts: page.entries, page: page)
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", selected_tags: changeset.post.tags, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post_by_slug!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post_by_slug!(id)
    changeset = Blog.change_post(post)
    selected_tags = Enum.map(post.tags, &(&1.id))
    render(conn, "edit.html", selected_tags: selected_tags, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post_by_slug!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", selected_tags: post.tags, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post_by_slug!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
