defmodule FoodOrderWeb.CartLive.Details.ItemTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  describe "load page" do
    setup :register_and_log_in_user

    test "load two items component", %{conn: conn} do
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

      assert has_element?(view, "##{product.id}")
      assert has_element?(view, "##{product_2.id}")

      assert has_element?(view, "##{product.id}>div>h1", product.name)
      assert has_element?(view, "##{product_2.id}>div>h1", product.name)

      assert has_element?(view, "##{product.id}>div>span", Atom.to_string(product.size))
      assert has_element?(view, "##{product_2.id}>div>span", Atom.to_string(product.size))

      assert has_element?(view, "[data-role=items][data-id=#{product.id}]", "2 Item(s)")
      assert has_element?(view, "[data-role=items][data-id=#{product_2.id}]", "1 Item(s)")

      assert has_element?(
               view,
               "[data-role=price][data-id=#{product.id}]",
               Money.to_string(product.price)
             )

      assert has_element?(
               view,
               "[data-role=price][data-id=#{product_2.id}]",
               Money.to_string(product_2.price)
             )
    end

    test "decrement 1 item", %{conn: conn} do
      product = product_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      product_element = build_product_element(product.id)

      view
      |> add(product_element, conn)
      |> add(product_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "[data-role=items][data-id=#{product.id}]", "2 Item(s)")

      event(view, product.id, "dec")

      assert has_element?(view, "[data-role=items][data-id=#{product.id}]", "1 Item(s)")
    end

    test "decrement until remove", %{conn: conn} do
      product = product_fixture()
      {:ok, view, _html} = live(conn, ~p"/")

      product_element = build_product_element(product.id)

      view
      |> add(product_element, conn)
      |> add(product_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "[data-role=items][data-id=#{product.id}]", "2 Item(s)")

      event(view, product.id, "dec")
      event(view, product.id, "dec")

      refute has_element?(view, "[data-role=items][data-id=#{product.id}]", "2 Item(s)")
    end

    test "increment item", %{conn: conn} do
      product = product_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      product_element = build_product_element(product.id)

      view
      |> add(product_element, conn)
      |> add(product_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "[data-role=items][data-id=#{product.id}]", "2 Item(s)")

      event(view, product.id, "inc")

      assert has_element?(view, "[data-role=items][data-id=#{product.id}]", "3 Item(s)")
    end

    test "remove item", %{conn: conn} do
      product = product_fixture()
      {:ok, view, _html} = live(conn, ~p"/")
      product_element = build_product_element(product.id)

      view
      |> add(product_element, conn)
      |> add(product_element, conn)

      {:ok, view, _html} = live(conn, ~p"/cart")

      assert has_element?(view, "[data-role=items][data-id=#{product.id}]", "2 Item(s)")

      event(view, product.id, "remove")
      refute has_element?(view, "[data-role=items][data-id=#{product.id}]", "2 Item(s)")
    end
  end

  defp event(view, product_id, event) do
    view
    |> element("[data-role=#{event}][data-id=#{product_id}]")
    |> render_click()
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
