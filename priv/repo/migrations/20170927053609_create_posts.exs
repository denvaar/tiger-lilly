defmodule TigerLilly.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :text
      add :title, :string
      add :summary, :string
      add :published, :boolean, default: false, null: false
      add :date_published, :utc_datetime

      timestamps()
    end

  end
end
