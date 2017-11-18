defmodule TigerLilly.Repo.Migrations.CreateNuggetes do
  use Ecto.Migration

  def change do
    create table(:nuggetes) do
      add :date, :utc_datetime
      add :description, :text

      timestamps()
    end

  end
end
