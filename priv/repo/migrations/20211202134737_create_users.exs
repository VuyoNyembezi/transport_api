defmodule TransportApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :email, :string
      add :password_hash, :string
      add :cell, :integer

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
