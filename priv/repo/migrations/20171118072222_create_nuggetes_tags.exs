defmodule TigerLilly.Repo.Migrations.CreateNuggetesTags do
  use Ecto.Migration

  def change do
    create table(:nuggetes_tags, primary_key: false) do
      add :nugget_id, references(:nuggetes)
      add :tag_id, references(:tags)
    end
  end
end
