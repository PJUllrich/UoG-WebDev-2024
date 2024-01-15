defmodule Movies.Repo.Migrations.AddPgroongaExtension do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS pgroonga;", "DROP EXTENSION IF EXISTS pgroonga;")
  end
end
