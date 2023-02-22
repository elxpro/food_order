defmodule FoodOrderWeb.Admin.OrderLive.IndexTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "index" do
    setup [:register_and_log_in_admin_user]

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/orders")
      assert has_element?(view, "#side-menu")
      assert has_element?(view, "[data-role=layers]")
      assert has_element?(view, "#NOT_STARTED")
      assert has_element?(view, "#RECEIVED")
      assert has_element?(view, "#PREPARING")
      assert has_element?(view, "#DELIVERING")
      assert has_element?(view, "#DELIVERED")
    end
  end
end
