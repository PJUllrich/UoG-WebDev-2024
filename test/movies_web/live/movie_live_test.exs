defmodule MoviesWeb.MovieLiveTest do
  use MoviesWeb.ConnCase

  import Phoenix.LiveViewTest
  import Movies.MovieRepoFixtures

  @create_attrs %{description: "some description", title: "some title", year: 42, rating: "some rating", review_user_count: 42, review_user_score: 120.5, review_meta_score: 42, imdb_url: "some imdb_url"}
  @update_attrs %{description: "some updated description", title: "some updated title", year: 43, rating: "some updated rating", review_user_count: 43, review_user_score: 456.7, review_meta_score: 43, imdb_url: "some updated imdb_url"}
  @invalid_attrs %{description: nil, title: nil, year: nil, rating: nil, review_user_count: nil, review_user_score: nil, review_meta_score: nil, imdb_url: nil}

  defp create_movie(_) do
    movie = movie_fixture()
    %{movie: movie}
  end

  describe "Index" do
    setup [:create_movie]

    test "lists all movies", %{conn: conn, movie: movie} do
      {:ok, _index_live, html} = live(conn, ~p"/movies")

      assert html =~ "Listing Movies"
      assert html =~ movie.description
    end

    test "saves new movie", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/movies")

      assert index_live |> element("a", "New Movie") |> render_click() =~
               "New Movie"

      assert_patch(index_live, ~p"/movies/new")

      assert index_live
             |> form("#movie-form", movie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#movie-form", movie: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/movies")

      html = render(index_live)
      assert html =~ "Movie created successfully"
      assert html =~ "some description"
    end

    test "updates movie in listing", %{conn: conn, movie: movie} do
      {:ok, index_live, _html} = live(conn, ~p"/movies")

      assert index_live |> element("#movies-#{movie.id} a", "Edit") |> render_click() =~
               "Edit Movie"

      assert_patch(index_live, ~p"/movies/#{movie}/edit")

      assert index_live
             |> form("#movie-form", movie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#movie-form", movie: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/movies")

      html = render(index_live)
      assert html =~ "Movie updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes movie in listing", %{conn: conn, movie: movie} do
      {:ok, index_live, _html} = live(conn, ~p"/movies")

      assert index_live |> element("#movies-#{movie.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#movies-#{movie.id}")
    end
  end

  describe "Show" do
    setup [:create_movie]

    test "displays movie", %{conn: conn, movie: movie} do
      {:ok, _show_live, html} = live(conn, ~p"/movies/#{movie}")

      assert html =~ "Show Movie"
      assert html =~ movie.description
    end

    test "updates movie within modal", %{conn: conn, movie: movie} do
      {:ok, show_live, _html} = live(conn, ~p"/movies/#{movie}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Movie"

      assert_patch(show_live, ~p"/movies/#{movie}/show/edit")

      assert show_live
             |> form("#movie-form", movie: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#movie-form", movie: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/movies/#{movie}")

      html = render(show_live)
      assert html =~ "Movie updated successfully"
      assert html =~ "some updated description"
    end
  end
end
