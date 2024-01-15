# Movies

To start your Phoenix server:

  * Install Elixir. See instructions [here](https://elixir-lang.org/install.html)
  * Start the Postgres Docker container with: `docker compose up -d`
  * Run `mix deps.get` to install the dependencies
  * Run `mix ecto.create` to create the database
  * Import the Movies dataset with `cd ./priv/repo && ./import.sh` (this might take a while)
  * Run `mix ecto.migrate` to add the search indexes.
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
