defmodule FoodOrderWeb.PageLiveTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  describe "index" do
    setup [:create_product]

    test "list all products", %{conn: conn, product: _product} do
      {:ok, view, _html} = live(conn, ~p"/admin/products")

      assert has_element?(view, "header>div>h1", "List Products")
    end
  end

  def create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
