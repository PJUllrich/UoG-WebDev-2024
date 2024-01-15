defmodule Movies.Repo.Migrations.AddSearchIndexToMovies do
  use Ecto.Migration

  def change do
    execute(
      """
      CREATE INDEX movies_pgroonga_index
        ON movies
        USING PGroonga ((ARRAY[title, description]));
      """,
      """
      DROP INDEX IF EXISTS movies_pgroonga_index;
      """
    )
  end
end
