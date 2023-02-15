defmodule FoodOrderWeb.PageLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrderWeb.PageLive.Item

  def mount(_, _, socket) do
    socket =
      socket
      |> assign(page: 1, per_page: 8)
      |> list_products()

    {:ok, socket}
  end

  def handle_event("load_more_products", _, socket) do
    socket =
      socket
      |> update(:page, &(&1 + 1))
      |> list_products

    {:noreply, socket}
  end

  defp list_products(socket) do
    page = socket.assigns.page
    per_page = socket.assigns.per_page
    paginate = [{:paginate, %{page: page, per_page: per_page}}]
    assign(socket, products: Products.list_products(paginate))
  end
end
