defmodule Movies.Repo.Migrations.CreateTemperatures do
  use Ecto.Migration

  def change do
    create table(:temperatures) do
      add :value, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
