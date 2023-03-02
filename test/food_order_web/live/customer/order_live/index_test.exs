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

    test "send to another layer using the handle_info using pid", %{conn: conn, user: user} do
      product = product_fixture()
      order = order_fixtures(product, user)

      {:ok, view, _html} = live(conn, ~p"/customer/orders")
      assert view |> element("td", "Not started") |> render() =~ "text-orange-600"

      order = Map.put(order, :status, :DELIVERED)
      send(view.pid, {:update_order_user_row, order})

      refute view |> element("td", "Delivered") |> render() =~ "text-orange-600"
    end
  end
end
