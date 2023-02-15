defmodule FoodOrderWeb.PageLiveTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  test "load main hero html", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    hero_cta = "[data-role=hero-cta]"
    assert has_element?(view, "[data-role=hero]")
    assert has_element?(view, hero_cta)

    assert view |> element(hero_cta <> ">h6") |> render() =~ "Make your order"
    assert view |> element(hero_cta <> ">h1") |> render() =~ "Right now!"
    assert view |> element(hero_cta <> ">button") |> render() =~ "Order now"
    assert has_element?(view, "[data-role=hero-img]")
  end

  test "load products", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "[data-role=products-section]")
    assert has_element?(view, "[data-role=products-section]>h1", "All foods")
    assert has_element?(view, "[data-role=products-list]")
  end

  test "load main item elements", %{conn: conn} do
    product = product_fixture()

    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "[data-role=item][data-id=#{product.id}]")
    assert has_element?(view, "[data-role=item][data-id=#{product.id}]>img")

    assert has_element?(view, "[data-role=item-details][data-id=#{product.id}]>h2", product.name)

    assert has_element?(
             view,
             "[data-role=item-details][data-id=#{product.id}]>span",
             Atom.to_string(product.size)
           )

    assert has_element?(
             view,
             "[data-role=item-details][data-id=#{product.id}]>div>span",
             Money.to_string(product.price)
           )

    assert view
           |> element("[data-role=item-details][data-id=#{product.id}]>div>button")
           |> render() =~ "add"
  end

  test "load more products", %{conn: conn} do
    products = for _ <- 0..12, do: product_fixture()

    {:ok, view, _html} = live(conn, ~p"/")

    [products_page_1, products_page_2] = products |> Enum.chunk_every(8)

    Enum.each(products_page_1, fn product ->
      assert has_element?(view, "[data-role=item][data-id=#{product.id}]")
    end)

    Enum.each(products_page_2, fn product ->
      refute has_element?(view, "[data-role=item][data-id=#{product.id}]")
    end)

    view
    |> element("#load_more_products")
    |> render_hook("load_more_products", %{})

    Enum.each(products_page_2, fn product ->
      assert has_element?(view, "[data-role=item][data-id=#{product.id}]")
    end)
  end
end
