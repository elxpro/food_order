defmodule FoodOrder.Orders.GetOrderByIdAndCustomerIdTest do
  use FoodOrder.DataCase

  import FoodOrder.AccountsFixtures
  import FoodOrder.OrdersFixtures
  import FoodOrder.ProductsFixtures

  alias FoodOrder.Orders.GetOrderByIdAndCustomerId

  test "return orders from using order_id and customer_id" do
    product = product_fixture()
    user = user_fixture()
    order = order_fixtures(product, user)

    assert order.id == GetOrderByIdAndCustomerId.execute(order.id, order.user_id).id
  end
end
