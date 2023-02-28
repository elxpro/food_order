defmodule FoodOrderWeb.Customer.OrderLive.IndexTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import FoodOrder.OrdersFixtures
  import Phoenix.LiveViewTest

  describe "load page" do
    setup :register_and_log_in_user

    test "check order list", %{conn: conn, user: user} do
      product = product_fixture()
      order = order_fixtures(product, user)
      {:ok, view, _html} = live(conn, ~p"/customer/orders")

      assert has_element?(view, "##{order.id}")
    end
  end
end
