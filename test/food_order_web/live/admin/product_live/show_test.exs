defmodule FoodOrderWeb.PageLive.ShowTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  describe "show" do
    setup [:create_product, :register_and_log_in_admin_user]

    test "display product", %{conn: conn, product: product} do
      {:ok, view, _html} = live(conn, ~p"/admin/products/#{product}")
      assert has_element?(view, "div>dt", "Name")
      assert has_element?(view, "div>dd", product.name)
    end
  end

  def create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
