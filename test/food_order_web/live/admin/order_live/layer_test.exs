defmodule FoodOrderWeb.Admin.OrderLive.Index.LayerTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "layer test" do
    setup [:register_and_log_in_admin_user]

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/orders")
      assert has_element?(view, "h3", "Not started")
    end
  end
end
