defmodule FoodOrder.Orders.ListOrdersByUserIdTest do
  use FoodOrder.DataCase

  import FoodOrder.AccountsFixtures
  import FoodOrder.OrdersFixtures
  import FoodOrder.ProductsFixtures

  alias FoodOrder.Orders.ListOrdersByUserId

  test "return orders by user id" do
    product = product_fixture()
    user = user_fixture()
    order_fixtures(product, user)
    assert 1 == ListOrdersByUserId.execute(user.id) |> Enum.count()
  end
end
