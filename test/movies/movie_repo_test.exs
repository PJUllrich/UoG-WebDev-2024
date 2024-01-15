defmodule Movies.MovieRepoTest do
  use Movies.DataCase

  alias Movies.MovieRepo

  describe "movies" do
    alias Movies.MovieRepo.Movie

    import Movies.MovieRepoFixtures

    @invalid_attrs %{
      description: nil,
      title: nil,
      year: nil,
      rating: nil,
      review_user_count: nil,
      review_user_score: nil,
      review_meta_score: nil,
      imdb_url: nil
    }

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert MovieRepo.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert MovieRepo.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        year: 42,
        rating: "some rating",
        review_user_count: 42,
        review_user_score: 120.5,
        review_meta_score: 42,
        imdb_url: "some imdb_url"
      }

      assert {:ok, %Movie{} = movie} = MovieRepo.create_movie(valid_attrs)
      assert movie.description == "some description"
      assert movie.title == "some title"
      assert movie.year == 42
      assert movie.rating == "some rating"
      assert movie.review_user_count == 42
      assert movie.review_user_score == 120.5
      assert movie.review_meta_score == 42
      assert movie.imdb_url == "some imdb_url"
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MovieRepo.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        year: 43,
        rating: "some updated rating",
        review_user_count: 43,
        review_user_score: 456.7,
        review_meta_score: 43,
        imdb_url: "some updated imdb_url"
      }

      assert {:ok, %Movie{} = movie} = MovieRepo.update_movie(movie, update_attrs)
      assert movie.description == "some updated description"
      assert movie.title == "some updated title"
      assert movie.year == 43
      assert movie.rating == "some updated rating"
      assert movie.review_user_count == 43
      assert movie.review_user_score == 456.7
      assert movie.review_meta_score == 43
      assert movie.imdb_url == "some updated imdb_url"
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = MovieRepo.update_movie(movie, @invalid_attrs)
      assert movie == MovieRepo.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = MovieRepo.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> MovieRepo.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = MovieRepo.change_movie(movie)
    end
  end
end
