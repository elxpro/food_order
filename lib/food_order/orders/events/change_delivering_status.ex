defmodule FoodOrder.Orders.Events.ChangeDeliveringStatus do
  alias Phoenix.PubSub
  @pubsub FoodOrder.PubSub
  @topic "change-delivering"

  def subscribe(order_id), do: PubSub.subscribe(@pubsub, @topic <> order_id)

  def broadcast(deliver, deliver_old, order_id) do
    PubSub.broadcast(@pubsub, @topic <> order_id, {:change_delivering, deliver, deliver_old})
  end
end
