defmodule FoodOrder.Orders do
  alias __MODULE__.Events.NewOrder
  alias __MODULE__.AllStatusOrders

  defdelegate subscribe_to_receive_new_orders, to: NewOrder, as: :subscribe
  defdelegate all_status_orders, to: AllStatusOrders, as: :execute
end
