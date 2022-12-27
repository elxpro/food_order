defmodule FoodOrderWeb.Admin.ProductLive.Index do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

  def mount(_, _, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products)}
  end

  def handle_params(_params, _, socket) do
    live_action =  socket.assigns.live_action
    {:noreply, apply_action(socket, live_action)}
  end

  defp apply_action(socket, :new) do
    socket |> assign(:page_tittle, "New Product") |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index) do
    socket |> assign(:page_tittle, "List Products")
  end
end
