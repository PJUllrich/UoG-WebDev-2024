defmodule Movies.MovieRepo.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field(:description, :string)
    field(:title, :string)
    field(:year, :integer)
    field(:rating, :string)
    field(:review_usercount, :integer)
    field(:review_userscore, :decimal)
    field(:review_metascore, :integer)
    field(:imdburl, :string)
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [
      :title,
      :rating,
      :year,
      :description,
      :review_usercount,
      :review_userscore,
      :review_metascore,
      :imdburl
    ])
    |> validate_required([
      :title,
      :rating,
      :year,
      :description,
      :review_usercount,
      :review_userscore,
      :review_metascore,
      :imdburl
    ])
  end
end
