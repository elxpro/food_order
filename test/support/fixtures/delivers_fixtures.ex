defmodule FoodOrder.DeliversFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodOrder.Delivers` context.
  """

  @doc """
  Generate a deliver.
  """
  def deliver_fixture(attrs \\ %{}) do
    {:ok, deliver} =
      attrs
      |> Enum.into(%{
        lat: 120.5,
        lng: 120.5,
        name: "some name"
      })
      |> FoodOrder.Delivers.create_deliver()

    deliver
  end
end
