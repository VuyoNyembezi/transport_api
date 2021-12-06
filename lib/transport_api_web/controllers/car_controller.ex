defmodule TransportApiWeb.CarController do
  use TransportApiWeb, :controller

  alias TransportApi.Transport
  alias TransportApi.Transport.Car

  action_fallback TransportApiWeb.FallbackController

  def index(conn, _params) do
    cars = Transport.list_cars()
    render(conn, "index.json", cars: cars)
  end

  def create(conn, %{"car" => car_params}) do
    with {:ok, %Car{} = car} <- Transport.create_car(car_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.car_path(conn, :show, car))
      |> render("show.json", car: car)
    end
  end

  def show(conn, %{"id" => id}) do
    car = Transport.get_car!(id)
    render(conn, "show.json", car: car)
  end

  def update(conn, %{"id" => id, "car" => car_params}) do
    car = Transport.get_car!(id)

    with {:ok, %Car{} = car} <- Transport.update_car(car, car_params) do
      render(conn, "show.json", car: car)
    end
  end

  def delete(conn, %{"id" => id}) do
    car = Transport.get_car!(id)

    with {:ok, %Car{}} <- Transport.delete_car(car) do
      send_resp(conn, :no_content, "")
    end
  end
end
