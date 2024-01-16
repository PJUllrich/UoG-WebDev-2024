defmodule Movies.TempsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.Temps` context.
  """

  @doc """
  Generate a temp.
  """
  def temp_fixture(attrs \\ %{}) do
    {:ok, temp} =
      attrs
      |> Enum.into(%{
        value: 42
      })
      |> Movies.Temps.create_temp()

    temp
  end
end
