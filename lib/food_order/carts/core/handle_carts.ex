defmodule FoodOrder.Carts.Core.HandleCarts do
  alias FoodOrder.Carts.Data.Cart

  def create(cart_id) do
    Cart.new(cart_id)
  end

  def add(cart, item) do
    new_total_price = Money.add(cart.total_price, item.price)

    %{
      cart
      | total_qty: cart.total_qty + 1,
        items: cart.items ++ [item],
        total_price: new_total_price,
        total_items: cart.total_items + 1
    }
  end
end
