defmodule TransportApiWeb.CarView do
  use TransportApiWeb, :view
  alias TransportApiWeb.CarView

  def render("index.json", %{cars: cars}) do
    %{data: render_many(cars, CarView, "car.json")}
  end

  def render("show.json", %{car: car}) do
    %{data: render_one(car, CarView, "car.json")}
  end

  def render("car.json", %{car: car}) do
    %{
      id: car.id,
      name: car.name,
      year: car.year,
      model: car.model,
      price: car.price,
      features: car.features
    }
  end
end
