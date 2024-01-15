defmodule MoviesWeb.MovieLive.Index do
  use MoviesWeb, :live_view

  alias Movies.MovieRepo
  alias Movies.MovieRepo.Movie

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :movies, MovieRepo.list_movies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Movie")
    |> assign(:movie, MovieRepo.get_movie!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Movie")
    |> assign(:movie, %Movie{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Movies")
    |> assign(:movie, nil)
  end

  @impl true
  def handle_info({MoviesWeb.MovieLive.FormComponent, {:saved, movie}}, socket) do
    {:noreply, stream_insert(socket, :movies, movie)}
  end

  @impl true
  def handle_event("search", %{"query" => ""}, socket) do
    {:noreply, stream(socket, :movies, MovieRepo.list_movies(), reset: true)}
  end

  def handle_event("search", %{"query" => search}, socket) do
    {:noreply, stream(socket, :movies, MovieRepo.search_movies(search), reset: true)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    movie = MovieRepo.get_movie!(id)
    {:ok, _} = MovieRepo.delete_movie(movie)

    {:noreply, stream_delete(socket, :movies, movie)}
  end
end
