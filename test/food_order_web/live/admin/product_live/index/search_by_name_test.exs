defmodule FoodOrderWeb.Admin.PageLive.Index.SearchByNameTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  describe "search_by_name" do
    setup [:register_and_log_in_admin_user]

    test "search by name", %{conn: conn} do
      {product_1, product_2} = create_products()

      {:ok, view, _html} = live(conn, ~p"/admin/products")
      product_1_id = "#products-#{product_1.id}"
      product_2_id = "#products-#{product_2.id}"

      assert has_element?(view, product_1_id)
      assert has_element?(view, product_2_id)

      search_form(view, product_2.name)

      refute has_element?(view, product_1_id)
      assert has_element?(view, product_2_id)
    end

    test "search by invalid name", %{conn: conn} do
      {product_1, product_2} = create_products()

      {:ok, view, _html} = live(conn, ~p"/admin/products")
      product_1_id = "#products-#{product_1.id}"
      product_2_id = "#products-#{product_2.id}"

      assert has_element?(view, product_1_id)
      assert has_element?(view, product_2_id)

      search_form(view, "sadlkfjasdljkfljaksdfl")

      refute has_element?(view, product_1_id)
      refute has_element?(view, product_2_id)
    end

    test "search by empty name", %{conn: conn} do
      {product_1, product_2} = create_products()

      {:ok, view, _html} = live(conn, ~p"/admin/products")
      product_1_id = "#products-#{product_1.id}"
      product_2_id = "#products-#{product_2.id}"

      assert has_element?(view, product_1_id)
      assert has_element?(view, product_2_id)

      search_form(view, "")

      assert has_element?(view, product_1_id)
      assert has_element?(view, product_2_id)
    end
  end

  defp search_form(view, name) do
    view
    |> form("[phx-submit=filter_by_name]", %{name: name})
    |> render_submit()
  end

  defp create_products do
    product_1 = product_fixture()
    product_2 = product_fixture(name: "pumpkin")
    {product_1, product_2}
  end
end
