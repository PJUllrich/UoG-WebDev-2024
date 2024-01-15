defmodule MoviesWeb.MovieLive.Helpers do
  def query_params(opts, overrides) do
    default_params = [
      sort_by: opts.sort_by,
      order: opts.order,
      search: opts.search
    ]

    Keyword.merge(default_params, overrides)
  end
end
