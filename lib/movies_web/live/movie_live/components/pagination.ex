defmodule MoviesWeb.MovieLive.PaginationComponent do
  use MoviesWeb, :html

  alias MoviesWeb.MovieLive.Helpers

  def show(assigns) do
    ~H"""
    <% total_pages = calc_total_pages(@opts.total_count, @opts.page_size) %>
    <nav
      :if={total_pages > 0}
      class="isolate inline-flex -space-x-px rounded-md shadow-sm"
      aria-label="Pagination"
    >
      <.link
        navigate={~p"/?#{Helpers.query_params(@opts, page: max(1, @opts.page - 1))}"}
        class="relative inline-flex justify-center items-center rounded-l-md px-2 py-2 text-black ring-1 ring-inset ring-gray-500 hover:bg-gray-200 focus:z-20 focus:outline-offset-0"
      >
        <span class="sr-only">Previous</span>
        <.icon name="hero-chevron-left" class="w-4 h-4" />
      </.link>
      <.link
        :for={page <- gen_pages(total_pages, @opts.page)}
        navigate={~p"/?#{Helpers.query_params(@opts, page: page)}"}
        class={[
          "text-center relative items-center px-4 py-2 text-sm font-semibold text-black ring-1 ring-inset ring-slate-500 hover:bg-slate-200 focus:z-20 focus:outline-offset-0",
          @opts.page == page && "z-10 bg-slate-200"
        ]}
      >
        <%= page %>
      </.link>
      <.link
        navigate={~p"/?#{Helpers.query_params(@opts, page: min(total_pages, @opts.page + 1))}"}
        class="relative inline-flex justify-center items-center rounded-r-md px-2 py-2 text-black ring-1 ring-inset ring-slate-500 hover:bg-gray-200 focus:z-20 focus:outline-offset-0"
      >
        <span class="sr-only">Next</span>
        <.icon name="hero-chevron-right" class="w-4 h-4" />
      </.link>
    </nav>
    """
  end

  @max_displayed_pages 5

  def calc_total_pages(total_count, page_size) do
    (total_count / 1.0 / page_size) |> Float.ceil() |> trunc()
  end

  def gen_pages(total_pages, page) do
    if total_pages <= @max_displayed_pages do
      Enum.to_list(1..total_pages)
    else
      left = max(page - 2, 1)
      right = min(page + 2, total_pages)
      all = Enum.to_list(left..right) ++ [1, total_pages]
      all |> Enum.uniq() |> Enum.sort()
    end
  end
end
