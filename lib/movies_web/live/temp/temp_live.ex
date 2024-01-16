defmodule MoviesWeb.TempLive do
  use MoviesWeb, :live_view

  alias Phoenix.LiveView.JS

  alias Movies.Temps

  def render(assigns) do
    ~H"""
    <div class="meter">
      <span><%= @temp.value %>°C</span>
      <div>
        <button phx-click="dec" phx-disable-with="Loading...">-</button>
        <button phx-click="inc" phx-disable-with="Loading...">+</button>
      </div>
    </div>
    """
  end

  def mount(_params, session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(Movies.PubSub, "temps")
    {:ok, temp} = Temps.create_temp(%{value: 21})
    {:ok, assign(socket, temp: temp)}
  end

  def handle_info({:updated, temp}, socket) do
    {:noreply, assign(socket, temp: temp)}
  end

  def handle_event("inc", _params, socket) do
    temp = socket.assigns.temp
    {:ok, temp} = Temps.update_temp(temp, %{value: temp.value + 1})
    {:noreply, socket}
  end

  def handle_event("dec", _params, socket) do
    temp = socket.assigns.temp
    {:ok, temp} = Temps.update_temp(temp, %{value: temp.value - 1})
    {:noreply, socket}
  end
end
