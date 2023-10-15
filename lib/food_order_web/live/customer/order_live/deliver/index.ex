defmodule FoodOrderWeb.OrderLive.Deliver do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders
  alias FoodOrder.Delivers


  def handle_params(%{"id" => id}, _, socket) do
    order = Orders.get(id)
    deliver = FoodOrder.Repo.preload(order, :deliver).deliver
    {:noreply, assign(socket, order: order, deliver: deliver)}
  end

  def handle_event("update-order", params, socket) do
    deliver = socket.assigns.deliver
    order = socket.assigns.order
    Delivers.update_deliver_and_notify_the_order(deliver, params, order)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
      <div>
        <div>
          The order: <%= @order.id %>, Deliver: <%= @deliver.id %> <%= @deliver.name %>
          Position:
          <div phx-hook="DeliverPosition" id={@order.id}>
            <div></div>
          </div>
        </div>
      </div>
    """
  end
end
