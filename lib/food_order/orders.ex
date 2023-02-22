defmodule FoodOrder.Orders do
  alias __MODULE__.Events.NewOrder

  defdelegate subscribe_to_receive_new_orders, to: NewOrder, as: :subscribe
end
