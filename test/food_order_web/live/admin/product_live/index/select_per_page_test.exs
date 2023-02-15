defmodule FoodOrderWeb.Admin.ProductLive.Index.SelectPerPageTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "select per page component" do
    setup [:register_and_log_in_admin_user]

    test "clicking to change to 20 pages", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/products")

      view
      |> form("#select-per-page", %{"per-page-select" => "20"})
      |> render_change()

      assert_patched(
        view,
        ~p"/admin/products?name=&page=1&per_page=20&sort_by=updated_at&sort_order=desc"
      )
    end
  end
end
