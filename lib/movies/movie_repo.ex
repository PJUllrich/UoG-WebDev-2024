defmodule Movies.MovieRepo do
  @moduledoc """
  The MovieRepo context.
  """

  import Ecto.Query, warn: false
  alias Movies.Repo

  alias Movies.MovieRepo.Movie

  @doc """
  Returns the list of movies.

  ## Examples

      iex> list_movies()
      [%Movie{}, ...]

  """
  def list_movies(%{
        sort_by: sort_by,
        order: order,
        page: page,
        page_size: page_size,
        search: search
      }) do
    query = Movie |> order_by({^order, ^sort_by}) |> maybe_search(search)
    total_count = Repo.aggregate(query, :count)

    offset = (page - 1) * page_size
    result = query |> offset(^offset) |> limit(^page_size) |> Repo.all()

    %{total_count: total_count, result: result}
  end

  def maybe_search(query, nil), do: query

  def maybe_search(query, search_term) do
    from(
      entry in query,
      where:
        fragment(
          "ARRAY[?, ?] &@~ (?, ARRAY[5, 1], 'entries_pgroonga_index')::pgroonga_full_text_search_condition",
          entry.title,
          entry.description,
          ^search_term
        ),
      order_by: fragment("pgroonga_score(tableoid, ctid) DESC")
    )
  end

  @doc """
  Gets a single movie.

  Raises `Ecto.NoResultsError` if the Movie does not exist.

  ## Examples

      iex> get_movie!(123)
      %Movie{}

      iex> get_movie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movie!(id), do: Repo.get!(Movie, id)

  @doc """
  Creates a movie.

  ## Examples

      iex> create_movie(%{field: value})
      {:ok, %Movie{}}

      iex> create_movie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movie(attrs \\ %{}) do
    %Movie{}
    |> Movie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movie.

  ## Examples

      iex> update_movie(movie, %{field: new_value})
      {:ok, %Movie{}}

      iex> update_movie(movie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movie(%Movie{} = movie, attrs) do
    movie
    |> Movie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movie.

  ## Examples

      iex> delete_movie(movie)
      {:ok, %Movie{}}

      iex> delete_movie(movie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movie(%Movie{} = movie) do
    Repo.delete(movie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movie changes.

  ## Examples

      iex> change_movie(movie)
      %Ecto.Changeset{data: %Movie{}}

  """
  def change_movie(%Movie{} = movie, attrs \\ %{}) do
    Movie.changeset(movie, attrs)
  end
end
