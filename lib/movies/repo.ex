defmodule Movies.Repo do
  use Ecto.Repo,
    otp_app: :movies,
    adapter: Ecto.Adapters.Postgres
end
