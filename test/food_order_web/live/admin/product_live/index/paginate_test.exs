defmodule FoodOrderWeb.Admin.ProductLive.Index.PaginateTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  describe "paginate component" do
    setup [:register_and_log_in_admin_user]

    test "clicking next, preview, and page", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/products")

      assert has_element?(view, "#pages")

      view
      |> element("[data-role=next]")
      |> render_click()

      assert_patched(
        view,
        ~p"/admin/products?name=&page=2&per_page=4&sort_by=updated_at&sort_order=desc"
      )

      view
      |> element("[data-role=previous]")
      |> render_click()

      assert_patched(
        view,
        ~p"/admin/products?name=&page=1&per_page=4&sort_by=updated_at&sort_order=desc"
      )

      view
      |> element("#pages>div>div>a", "2")
      |> render_click()

      assert_patched(
        view,
        ~p"/admin/products?name=&page=2&per_page=4&sort_by=updated_at&sort_order=desc"
      )
    end

    test "using params", %{conn: conn} do
      product_1 = product_fixture(name: "pumpkin")
      product_2 = product_fixture(name: "pumpkin 2")

      {:ok, view, _html} =
        live(
          conn,
          ~p"/admin/products?name=&page=1&per_page=1&sort_by=inserted_at&sort_order=desc"
        )

      assert has_element?(view, "#products-#{product_1.id}")
      refute has_element?(view, "#products-#{product_2.id}")

      view
      |> element("[data-role=next]")
      |> render_click()

      open_browser(view)

      assert has_element?(view, "#products-#{product_2.id}")
      refute has_element?(view, "#products-#{product_1.id}")
    end
  end
end
