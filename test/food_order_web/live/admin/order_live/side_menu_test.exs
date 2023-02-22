defmodule FoodOrderWeb.Admin.OrderLive.Index.SideMenuTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "side menu test" do
    setup [:register_and_log_in_admin_user]

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/orders")
      assert has_element?(view, "#side-menu")

      assert has_element?(view, "#side-menu>nav>h2", "Orders")

      assert has_element?(view, "#side-menu>nav>div>a>span", "All")
      assert has_element?(view, "#side-menu>nav>div>a>span", "30")

      assert has_element?(view, "#side-menu>nav>div>a>span", "Not Started")
      assert has_element?(view, "#side-menu>nav>div>a>span", "30")

      assert has_element?(view, "#side-menu>nav>div>a>span", "Received")
      assert has_element?(view, "#side-menu>nav>div>a>span", "30")

      assert has_element?(view, "#side-menu>nav>div>a>span", "Preparing")
      assert has_element?(view, "#side-menu>nav>div>a>span", "30")

      assert has_element?(view, "#side-menu>nav>div>a>span", "Delivering")
      assert has_element?(view, "#side-menu>nav>div>a>span", "30")

      assert has_element?(view, "#side-menu>nav>div>a>span", "Delivered")
      assert has_element?(view, "#side-menu>nav>div>a>span", "30")

    end
  end
end
