defmodule MoviesWeb.MovieLive.FormComponent do
  use MoviesWeb, :live_component

  alias Movies.MovieRepo

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage movie records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="movie-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:rating]} type="text" label="Rating" />
        <.input field={@form[:year]} type="number" label="Year" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:review_usercount]} type="number" label="Review user count" />
        <.input field={@form[:review_userscore]} type="number" label="Review user score" step="any" />
        <.input field={@form[:review_metascore]} type="number" label="Review meta score" />
        <.input field={@form[:imdburl]} type="text" label="Imdb url" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Movie</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{movie: movie} = assigns, socket) do
    changeset = MovieRepo.change_movie(movie)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"movie" => movie_params}, socket) do
    changeset =
      socket.assigns.movie
      |> MovieRepo.change_movie(movie_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"movie" => movie_params}, socket) do
    save_movie(socket, socket.assigns.action, movie_params)
  end

  defp save_movie(socket, :edit, movie_params) do
    case MovieRepo.update_movie(socket.assigns.movie, movie_params) do
      {:ok, movie} ->
        notify_parent({:saved, movie})

        {:noreply,
         socket
         |> put_flash(:info, "Movie updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_movie(socket, :new, movie_params) do
    case MovieRepo.create_movie(movie_params) do
      {:ok, movie} ->
        notify_parent({:saved, movie})

        {:noreply,
         socket
         |> put_flash(:info, "Movie created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
