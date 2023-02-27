defmodule FoodOrderWeb.CartLive.DetailsTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  describe "load page" do
    setup :register_and_log_in_user

    test "create success order", %{conn: conn} do
      product = product_fixture()
      product_2 = product_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      product_element = build_product_element(product.id)
      product_2_element = build_product_element(product_2.id)

      view
      |> add(product_element, conn)
      |> add(product_element, conn)
      |> add(product_2_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      {:ok, _view, html} =
        view
        |> form("#confirm-order-form", %{
          "phone_number" => "11231312312",
          "address" => "Abc street"
        })
        |> render_submit()
        |> follow_redirect(conn, ~p"/customer/orders")

      assert html =~ "hi"
    end

    test "error trying to create an order", %{conn: conn} do
      product = product_fixture()
      product_2 = product_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      product_element = build_product_element(product.id)
      product_2_element = build_product_element(product_2.id)

      view
      |> add(product_element, conn)
      |> add(product_element, conn)
      |> add(product_2_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      {:ok, _view, _html} =
        view
        |> form("#confirm-order-form", %{})
        |> render_submit()
        |> follow_redirect(conn, ~p"/cart")
    end
  end

  defp build_product_element(product_id) do
    "[data-id=#{product_id}]>div>div>button"
  end

  defp add(view, product_element, conn) do
    {:ok, view, _html} =
      view
      |> element(product_element)
      |> render_click()
      |> follow_redirect(conn, ~p"/")

    view
  end
end
