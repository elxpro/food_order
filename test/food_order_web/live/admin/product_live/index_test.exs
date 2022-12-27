defmodule FoodOrderWeb.PageLiveTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  describe "index" do
    setup [:create_product]

    test "list products", %{conn: conn, product: product} do
      {:ok, view, _html} = live(conn, ~p"/admin/products")

      assert has_element?(view, "header>div>h1", "List Products")

      product_id = "#products-#{product.id}"
      assert has_element?(view, product_id)
      assert has_element?(view, product_id <> ">td>div>span", product.name)
      assert has_element?(view, product_id <> ">td>div>span", Money.to_string(product.price))
      assert has_element?(view, product_id <> ">td>div>span", Atom.to_string(product.size))
    end
  end

  def create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
