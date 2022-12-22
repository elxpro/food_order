defmodule FoodOrderWeb.PageLiveTest do
  use FoodOrderWeb.ConnCase
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
    {:ok, view, _html} = live(conn, ~p"/")

    assert has_element?(view, "[data-role=item][data-id=1]")
    assert has_element?(view, "[data-role=item][data-id=1]>img")

    assert has_element?(view, "[data-role=item-details][data-id=1]>h2", "Product Name")
    assert has_element?(view, "[data-role=item-details][data-id=1]>span", "small")
    assert has_element?(view, "[data-role=item-details][data-id=1]>div>span", "$10")
    assert view |> element("[data-role=item-details][data-id=1]>div>button") |> render() =~ "add"
  end
end
