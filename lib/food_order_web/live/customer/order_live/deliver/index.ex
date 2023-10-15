defmodule FoodOrderWeb.OrderLive.Deliver do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Orders

  def handle_params(%{"id" => id}, _, socket) do
    order = Orders.get(id)
    {:noreply, assign(socket, order: order)}
  end

  def handle_event("update-order", params, socket) do
    IO.inspect params
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
      <div>
        <div>
          The order: <%= @order.id %>
          Position:
          <div phx-hook="DeliverPosition" id={@order.id}>
            <div></div>
          </div>
        </div>
      </div>
    """
  end
end
