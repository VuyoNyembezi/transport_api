defmodule TransportApi.TransportTest do
  use TransportApi.DataCase

  alias TransportApi.Transport

  describe "cars" do
    alias TransportApi.Transport.Car

    import TransportApi.TransportFixtures

    @invalid_attrs %{features: nil, model: nil, name: nil, price: nil, year: nil}

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Transport.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Transport.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      valid_attrs = %{features: [], model: "some model", name: "some name", price: 120.5, year: 42}

      assert {:ok, %Car{} = car} = Transport.create_car(valid_attrs)
      assert car.features == []
      assert car.model == "some model"
      assert car.name == "some name"
      assert car.price == 120.5
      assert car.year == 42
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transport.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      update_attrs = %{features: [], model: "some updated model", name: "some updated name", price: 456.7, year: 43}

      assert {:ok, %Car{} = car} = Transport.update_car(car, update_attrs)
      assert car.features == []
      assert car.model == "some updated model"
      assert car.name == "some updated name"
      assert car.price == 456.7
      assert car.year == 43
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Transport.update_car(car, @invalid_attrs)
      assert car == Transport.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Transport.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Transport.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Transport.change_car(car)
    end
  end
end
