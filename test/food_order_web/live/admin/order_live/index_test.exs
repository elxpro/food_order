defmodule FoodOrderWeb.Admin.OrderLive.IndexTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "index" do
    setup [:register_and_log_in_admin_user]

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/orders")
      assert has_element?(view, "#side-menu")
    end
  end
end
