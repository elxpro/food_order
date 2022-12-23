defmodule FoodOrderWeb.PageLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrderWeb.PageLive.Item

  def mount(_, _, socket) do
    {:ok, assign(socket, products: Products.list_products())}
  end
end
