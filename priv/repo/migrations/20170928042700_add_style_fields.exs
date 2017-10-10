defmodule TigerLilly.Repo.Migrations.AddStyleFields do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :hero_pattern_style, :string
      add :background_color_class, :string
    end
  end
end
