defmodule FoodOrderWeb.Customer.OrderLive.StatusTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import FoodOrder.OrdersFixtures
  import Phoenix.LiveViewTest

  describe "load page" do
    setup :register_and_log_in_user

    test "check order list", %{conn: conn, user: user} do
      product = product_fixture()
      order = order_fixtures(product, user)
      {:ok, view, _html} = live(conn, ~p"/customer/orders/#{order.id}")

      assert has_element?(view, "##{order.status}")
      assert has_element?(view, "##{order.status}>div>span", "Not started")
    end

    test "send to another layer using the handle_info using pid", %{conn: conn, user: user} do
      product = product_fixture()
      order = order_fixtures(product, user)

      {:ok, view, _html} = live(conn, ~p"/customer/orders/#{order.id}")
      assert view |> element("#NOT_STARTED") |> render() =~ "text-orange-500"
      refute view |> element("#RECEIVED") |> render() =~ "text-orange-500"

      order = Map.put(order, :status, :RECEIVED)
      send(view.pid, {:update_order, order})

      assert view |> element("#NOT_STARTED") |> render() =~ "text-orange-500"
      assert view |> element("#RECEIVED") |> render() =~ "text-orange-500"
    end
  end
end
