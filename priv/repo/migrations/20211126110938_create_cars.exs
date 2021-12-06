defmodule TransportApi.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :year, :integer
      add :model, :string
      add :price, :float
      add :features, {:array, :string}

      timestamps()
    end
  end
end
