defmodule FoodOrder.Orders.UpdateOrderStatus do
  alias FoodOrder.Orders.Order
  alias FoodOrder.Repo
  alias FoodOrder.Orders.Events.UpdateOrder

  def execute(order_id, old_status, new_status) do
    Order
    |> Repo.get(order_id)
    |> Order.changeset(%{status: new_status})
    |> Repo.update()
    |> UpdateOrder.broadcast_admin_orders_update(old_status)
    |> UpdateOrder.broadcast_update_user_row()
    |> UpdateOrder.broadcast_update_order()
  end
end
