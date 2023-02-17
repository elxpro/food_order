defmodule FoodOrder.Carts do
  @name :cart_session
  def create(cart_id), do: GenServer.cast(@name, {:create, cart_id})
  def add(cart_id, product), do: GenServer.cast(@name, {:add, cart_id, product})
  def get(cart_id), do: GenServer.call(@name, {:get, cart_id})
  def inc(cart_id, product_id), do: GenServer.call(@name, {:inc, cart_id, product_id})
  def dec(cart_id, product_id), do: GenServer.call(@name, {:dec, cart_id, product_id})
  def remove(cart_id, product_id), do: GenServer.call(@name, {:remove, cart_id, product_id})
end
