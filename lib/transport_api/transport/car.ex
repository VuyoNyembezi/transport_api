defmodule TransportApi.Transport.Car do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cars" do
    field :features, {:array, :string}
    field :model, :string
    field :name, :string
    field :price, :float
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:name, :year, :model, :price, :features])
    |> validate_required([:name, :year, :model, :price, :features])
    |> unique_constraint(:model)
  end
end
