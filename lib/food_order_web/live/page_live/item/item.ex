defmodule FoodOrderWeb.PageLive.Item do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Carts

  def handle_event("add", _, socket) do
    product = socket.assigns.product
    cart_id = socket.assigns.cart_id
    add_product_to_cart(cart_id, product)

    {:noreply,
     socket
     |> put_flash(:info, "Item added to cart")
     |> push_redirect(to: "/")}
  end

  defp product_detail(assigns) do
    ~H"""
    <h2 class="mb-4 text-lg"><%= @name %></h2>
    <span class="bg-neutral-200 py-1 px-4 rounded-full uppercase text-xs">
      <%= @size %>
    </span>
    """
  end

  defp product_info(assigns) do
    ~H"""
    <div class="mt-6 flex items-center justify-around">
      <span class="font-bold text-lg"><%= @price %></span>
      <button
        phx-click="add"
        phx-target={@myself}
        class="border-2 py-1 px-6 rounded-full border-orange-500 text-orange-500 transition  hover:bg-orange-500 hover:text-neutral-100"
      >
        <span>+</span>
        <span>add</span>
      </button>
    </div>
    """
  end

  defp add_product_to_cart(cart_id, product) do
    Carts.add(cart_id, product)
  end
end
