defmodule MoviesWeb.MovieLive.Index do
  use MoviesWeb, :live_view

  alias Movies.MovieRepo
  alias Movies.MovieRepo.Movie

  def reverse_order(:asc_nulls_last), do: :desc_nulls_last
  def reverse_order(:desc_nulls_last), do: :asc_nulls_last

  @default_opts %{
    "sort_by" => "id",
    "order" => "asc_nulls_last",
    "search" => ""
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> stream(:movies, []) |> assign(:opts, @default_opts)}
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

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Movies")
    |> assign(:movie, nil)
    |> assign_movies(params)
  end

  @impl true
  def handle_info({MoviesWeb.MovieLive.FormComponent, {:saved, movie}}, socket) do
    {:noreply, stream_insert(socket, :movies, movie)}
  end

  @impl true
  def handle_event("search", params, socket) do
    {:noreply, assign_movies(socket, params)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    movie = MovieRepo.get_movie!(id)
    {:ok, _} = MovieRepo.delete_movie(movie)

    {:noreply, stream_delete(socket, :movies, movie)}
  end

  defp assign_movies(socket, params) do
    opts = parse_opts(params)
    %{result: movies, total_count: total_count} = MovieRepo.list_movies(opts)

    socket
    |> stream(:movies, movies, reset: true)
    |> assign(:total_count, total_count)
    |> assign(:opts, opts)
  end

  defp parse_opts(params) do
    search = params |> Map.get("query", "") |> parse_search()
    sort_by = params |> Map.get("sort_by", "id") |> String.to_existing_atom()
    order = params |> Map.get("order", "asc_nulls_last") |> String.to_existing_atom()
    %{sort_by: sort_by, order: order, search: search, page_size: 10}
  end

  defp parse_search(""), do: nil
  defp parse_search(search), do: String.trim(search)
end
