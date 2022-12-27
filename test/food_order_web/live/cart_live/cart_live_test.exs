defmodule FoodOrderWeb.CartLiveTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest

  test "load main elements when cart is empty", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/cart")

    assert has_element?(view, "[data-role=cart]")
    assert has_element?(view, "[data-role=cart]>div>h1", "Your Cart is empty!")

    assert has_element?(
             view,
             "[data-role=cart]>div>p",
             "You probably haven`t ordered a food yet."
           )

    assert has_element?(
             view,
             "[data-role=cart]>div>p",
             "To order an good food, go to the main page."
           )

    assert has_element?(view, "[data-role=cart]>div>a", "Go back")
  end

  # test "load main elements when cart has items", %{conn: conn} do
  #   {:ok, view, _html} = live(conn, ~p"/cart")

  #   assert has_element?(view, "[data-role=cart]>div>div>h1", "Order Detail")

  #   assert has_element?(view, "[data-role=item-image]")

  #   assert has_element?(view, "[data-role=item]>div>h1", "Pizza")
  #   assert has_element?(view, "[data-role=item]>div>span", "Small")

  #   assert has_element?(view, "[data-role=quantity]")
  #   assert has_element?(view, "[data-role=dec]", "-")
  #   assert has_element?(view, "[data-role=quantity]>div>span", "10 Item(s)")
  #   assert has_element?(view, "[data-role=add]", "+")

  #   assert has_element?(view, "[data-role=total-item]>span", "$100")
  #   assert has_element?(view, "[data-role=total-item]>button", "&times")

  #   assert has_element?(view, "[data-role=total-cart]")
  #   assert has_element?(view, "[data-role=total-cart]>div>span", "Total Amount:")
  #   assert has_element?(view, "[data-role=total-cart]>div>span", "$1000")
  # end
end
