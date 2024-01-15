defmodule Movies.MovieRepoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.MovieRepo` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        description: "some description",
        imdb_url: "some imdb_url",
        rating: "some rating",
        review_meta_score: 42,
        review_user_count: 42,
        review_user_score: 120.5,
        title: "some title",
        year: 42
      })
      |> Movies.MovieRepo.create_movie()

    movie
  end
end
