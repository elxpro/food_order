defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Carts
  alias FoodOrderWeb.CartLive.Details

  def mount(_, _, socket) do
    cart_id = socket.assigns.cart_id
    cart = Carts.get(cart_id)
    {:ok, assign(socket, cart: cart)}
  end

  defp empty_cart(assigns) do
    ~H"""
    <div class="py-16 container mx-auto text-center">
      <h1 class="text-3xl font-bold mb-2">Your Cart is empty!</h1>
      <p class="text-neutral-500 text-lg mb-12">
        You probably haven`t ordered a food yet. <br /> To order an good food, go to the main page.
      </p>
      <Heroicons.shopping_bag solid class="w-20 h-20 mx-auto text-orange-500" />
      <a
        href={~p"/"}
        class="inline-block px-6 py-2 rounded-full bg-orange-500 text-white font-bold mt-12"
      >
        Go back
      </a>
    </div>
    """
  end
end
