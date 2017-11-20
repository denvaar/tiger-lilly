defmodule TigerLillyWeb.Api.V1.NuggetController do
  use TigerLillyWeb, :controller

  alias TigerLilly.TodayILearned
  alias TigerLilly.TodayILearned.Nugget

  def create(conn, nugget_params) do
    case TodayILearned.create_nugget(nugget_params) do
      {:ok, nugget} ->
        conn
        |> put_status(:created)
        |> render("show.json", nugget: nugget)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
    end
  end

  def update(conn, %{"id" => id} = nugget_params) do
    nugget = TodayILearned.get_nugget!(id)
    case TodayILearned.update_nugget(nugget, Map.delete(nugget_params, "id")) do
      {:ok, nugget} ->
        conn
        |> put_status(:accepted)
        |> render("show.json", nugget: nugget)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
    end
  end
end
