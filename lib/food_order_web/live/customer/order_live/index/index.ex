defmodule FoodOrderWeb.Customer.OrderLive.Index do
  use FoodOrderWeb, :live_view
  import Phoenix.Naming, only: [humanize: 1]
  alias FoodOrder.Orders


  def mount(_, _, socket) do
    current_user = socket.assigns.current_user
    if connected?(socket), do:  Orders.subscribe_update_user_row(current_user.id)

    orders = Orders.list_orders_by_user_id(current_user.id)
    socket = socket |> assign(orders: orders)
    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
      <div class="container mx-auto pt-12">
        <table class="w-full table-auto bg-white">
          <thead>
            <th class="px-4 py-2 text-left">Orders</th>
            <th class="px-4 py-2 text-left">Address</th>
            <th class="px-4 py-2 text-left">Status</th>
            <th class="px-4 py-2 text-left">Time</th>
          </thead>

          <tbody>
            <tr :for={order <- @orders} id={order.id}>
              <td class="border px-4 py-2">
                <.link href={~p"/customer/orders/#{order.id}"}><%= order.id %></.link>
              </td>
              <td class="border px-4 py-2">
                <%= order.address %> - <%= order.phone_number %>
              </td>
              <td class={[order.status != :DELIVERED && "text-orange-600" || "" , "border px-4 py-2"]}>
              <%= humanize(order.status) %>
              </td>
              <td class="border px-4 py-2">
              <%= order.updated_at |> NaiveDateTime.to_string() %>
              </td>
            </tr>

          </tbody>
        </table>
      </div>
    """
  end

end
