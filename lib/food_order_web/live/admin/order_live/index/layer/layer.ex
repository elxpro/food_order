defmodule FoodOrderWeb.Admin.OrderLive.Index.Layer do
  use FoodOrderWeb, :live_component
  import Phoenix.Naming, only: [humanize: 1]
  alias __MODULE__.Card
  alias FoodOrder.Orders

  def update(assigns, socket) do
    orders = Orders.list_orders_by_status(assigns.id)
    {:ok, socket |> assign(assigns) |> assign(cards: orders)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex-shrink-0 p-3 w-80 bg-gray-100 rounded-md m-2">
      <h3 class="text-sm font-medium text-gray-9000 uppercase"><%= humanize(@id) %></h3>

      <ul class="mt-2" id={@id} phx-hook="Drag">
        <.live_component :for={card <- @cards} module={Card} id={card.id} card={card} />
      </ul>
    </div>
    """
  end

  def handle_event(
        "dropped",
        %{
          "new_status" => new_status,
          "old_status" => old_status
        },
        socket
      )
      when new_status == old_status do
    {:noreply, socket}
  end

  def handle_event("dropped", params, socket) do
    %{
      "new_status" => new_status,
      "old_status" => old_status,
      "order_id" => order_id
    } = params

    Orders.update_order_status(order_id, old_status, new_status)
    {:noreply, socket}
  end
end
