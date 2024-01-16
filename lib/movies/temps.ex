defmodule Movies.Temps do
  @moduledoc """
  The Temps context.
  """

  import Ecto.Query, warn: false
  alias Movies.Repo

  alias Movies.Temps.Temp

  @doc """
  Returns the list of temperatures.

  ## Examples

      iex> list_temperatures()
      [%Temp{}, ...]

  """
  def list_temperatures do
    Repo.all(Temp)
  end

  @doc """
  Gets a single temp.

  Raises `Ecto.NoResultsError` if the Temp does not exist.

  ## Examples

      iex> get_temp!(123)
      %Temp{}

      iex> get_temp!(456)
      ** (Ecto.NoResultsError)

  """
  def get_temp!(id), do: Repo.get!(Temp, id)

  @doc """
  Creates a temp.

  ## Examples

      iex> create_temp(%{field: value})
      {:ok, %Temp{}}

      iex> create_temp(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_temp(attrs \\ %{}) do
    %Temp{}
    |> Temp.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a temp.

  ## Examples

      iex> update_temp(temp, %{field: new_value})
      {:ok, %Temp{}}

      iex> update_temp(temp, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_temp(%Temp{} = temp, attrs) do
    temp
    |> Temp.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, temp} ->
        Phoenix.PubSub.broadcast!(Movies.PubSub, "temps", {:updated, temp})
        {:ok, temp}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Deletes a temp.

  ## Examples

      iex> delete_temp(temp)
      {:ok, %Temp{}}

      iex> delete_temp(temp)
      {:error, %Ecto.Changeset{}}

  """
  def delete_temp(%Temp{} = temp) do
    Repo.delete(temp)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking temp changes.

  ## Examples

      iex> change_temp(temp)
      %Ecto.Changeset{data: %Temp{}}

  """
  def change_temp(%Temp{} = temp, attrs \\ %{}) do
    Temp.changeset(temp, attrs)
  end
end
