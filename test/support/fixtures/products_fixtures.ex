defmodule FoodOrder.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodOrder.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        image_url: "product_1.jpeg",
        price: 42
      })
      |> FoodOrder.Products.create_product()

    product
  end
end
