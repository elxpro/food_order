defmodule FoodOrderWeb.Admin.ProductLive.Show do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products

 def handle_params(%{"id" => id}, _, socket) do
    product = Products.get_product!(id)
   {:noreply, assign(socket, :product, product)}
 end
end
