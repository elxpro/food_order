defmodule FoodOrder.OrdersFixtures do
  alias FoodOrder.Orders.Order
  alias FoodOrder.Repo

  def order_fixtures(product, user, attrs \\ %{}) do
    order_attrs =
      attrs
      |> Enum.into(%{
        phone_number: "123",
        address: "123213",
        user_id: user.id,
        items: [%{quantity: 1, product_id: product.id}],
        total_quantity: 1,
        total_price: product.price
      })

    {:ok, order} =
      %Order{}
      |> Order.changeset(order_attrs)
      |> Repo.insert()

    order
  end
end
