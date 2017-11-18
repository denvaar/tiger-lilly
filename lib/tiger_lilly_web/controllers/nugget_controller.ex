defmodule TigerLillyWeb.NuggetController do
  use TigerLillyWeb, :controller

  alias TigerLilly.TodayILearned
  alias TigerLilly.TodayILearned.Nugget

  import TigerLilly.PostTagUtils

  plug :assign_available_tags when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    nuggetes = TodayILearned.list_nuggetes()
    render(conn, "index.html", nuggetes: nuggetes)
  end

  def new(conn, _params) do
    changeset = TodayILearned.change_nugget(%Nugget{})
    render(conn, "new.html", selected_tags: [], changeset: changeset)
  end

  def create(conn, %{"nugget" => nugget_params}) do
    case TodayILearned.create_nugget(nugget_params) do
      {:ok, nugget} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: nugget_path(conn, :show, nugget))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", selected_tags: changeset.changes.tags, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    nugget = TodayILearned.get_nugget!(id)
    render(conn, "show.html", nugget: nugget)
  end

  def edit(conn, %{"id" => id}) do
    nugget = TodayILearned.get_nugget!(id)
    changeset = TodayILearned.change_nugget(nugget)
    selected_tags = Enum.map(nugget.tags, &(&1.id))
    render(conn, "edit.html", nugget: nugget, selected_tags: selected_tags, changeset: changeset)
  end

  def update(conn, %{"id" => id, "nugget" => nugget_params}) do
    nugget = TodayILearned.get_nugget!(id)

    case TodayILearned.update_nugget(nugget, nugget_params) do
      {:ok, nugget} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: nugget_path(conn, :show, nugget))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", nugget: nugget, selected_tags: nugget.tags, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    nugget = TodayILearned.get_nugget!(id)
    {:ok, _nugget} = TodayILearned.delete_nugget(nugget)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: nugget_path(conn, :index))
  end
end
