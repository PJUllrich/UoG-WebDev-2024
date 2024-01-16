defmodule Movies.Temps.Temp do
  use Ecto.Schema
  import Ecto.Changeset

  schema "temperatures" do
    field :value, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(temp, attrs) do
    temp
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
