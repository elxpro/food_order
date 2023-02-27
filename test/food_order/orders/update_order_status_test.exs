defmodule FoodOrder.Orders.UpdateOrderStatusTest do
  use FoodOrder.DataCase

  import FoodOrder.AccountsFixtures
  import FoodOrder.OrdersFixtures
  import FoodOrder.ProductsFixtures

  alias FoodOrder.Orders.UpdateOrderStatus

  test "return orders by user id" do
    product = product_fixture()
    user = user_fixture()
    order = order_fixtures(product, user)
    assert {:ok, order_updated} = UpdateOrderStatus.execute(order.id, order.status, :DELIVERED)
    refute order.status == order_updated.status
  end
end
