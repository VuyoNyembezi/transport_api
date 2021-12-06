defmodule TransportApi.TransportFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TransportApi.Transport` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{
        features: [],
        model: "some model",
        name: "some name",
        price: 120.5,
        year: 42
      })
      |> TransportApi.Transport.create_car()

    car
  end
end
