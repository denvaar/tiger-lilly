defmodule TigerLilly.TodayILearned do
  @moduledoc """
  The TodayILearned context.
  """

  import Ecto.Query, warn: false
  alias TigerLilly.Repo

  alias TigerLilly.TodayILearned.Nugget
  alias TigerLilly.Blog.Tag

  @doc """
  Returns the list of nuggetes.

  ## Examples

      iex> list_nuggetes()
      [%Nugget{}, ...]

  """
  def list_nuggetes do
    Repo.all(Nugget)
  end

  @doc """
  Gets a single nugget.

  Raises `Ecto.NoResultsError` if the Nugget does not exist.

  ## Examples

      iex> get_nugget!(123)
      %Nugget{}

      iex> get_nugget!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nugget!(id) do
    Nugget
    |> Repo.get!(id)
    |> Repo.preload(:tags)
  end

  defp tag_ids_from(attrs) do
    attrs
    |> Map.get("tags", [])
    |> Enum.map(fn id -> String.to_integer(id) end)
  end

  defp put_tags_nugget(changeset, attrs) do
    ids = tag_ids_from(attrs)
    tags = Repo.all(from(t in Tag, where: t.id in ^ids))
    Ecto.Changeset.put_assoc(changeset, :tags, tags)
  end

  @doc """
  Creates a nugget.

  ## Examples

      iex> create_nugget(%{field: value})
      {:ok, %Nugget{}}

      iex> create_nugget(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nugget(attrs \\ %{}) do
    %Nugget{}
    |> Repo.preload(:tags)
    |> Nugget.changeset(attrs)
    |> put_tags_nugget(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nugget.

  ## Examples

      iex> update_nugget(nugget, %{field: new_value})
      {:ok, %Nugget{}}

      iex> update_nugget(nugget, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nugget(%Nugget{} = nugget, attrs) do
    nugget
    |> Repo.preload(:tags)
    |> Nugget.changeset(attrs)
    |> put_tags_nugget(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Nugget.

  ## Examples

      iex> delete_nugget(nugget)
      {:ok, %Nugget{}}

      iex> delete_nugget(nugget)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nugget(%Nugget{} = nugget) do
    Repo.delete(nugget)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nugget changes.

  ## Examples

      iex> change_nugget(nugget)
      %Ecto.Changeset{source: %Nugget{}}

  """
  def change_nugget(%Nugget{} = nugget) do
    Nugget.changeset(nugget, %{})
  end
end
