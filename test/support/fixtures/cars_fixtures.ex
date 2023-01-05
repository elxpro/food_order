defmodule FoodOrder.CarsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodOrder.Cars` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> FoodOrder.Cars.create_car()

    car
  end
end
