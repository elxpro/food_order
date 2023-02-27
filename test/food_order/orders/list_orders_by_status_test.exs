defmodule FoodOrder.Orders.ListOrdersByStatusTest do
  use FoodOrder.DataCase

  import FoodOrder.AccountsFixtures
  import FoodOrder.OrdersFixtures
  import FoodOrder.ProductsFixtures

  alias FoodOrder.Orders.ListOrdersByStatus

  test "return orders from using order_id and customer_id" do
    product = product_fixture()
    user = user_fixture()
    order_fixtures(product, user)
    assert 1 == ListOrdersByStatus.execute(:NOT_STARTED) |> Enum.count()
  end
end
