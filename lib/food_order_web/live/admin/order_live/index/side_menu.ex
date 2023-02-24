defmodule FoodOrderWeb.Admin.OrderLive.Index.SideMenu do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Orders

  def update(assigns, socket) do
    status = Orders.all_status_orders |> Map.from_struct()
    socket =
      socket
      |> assign(assigns)
      |> assign(status)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div id={@id} class="w-64 px-8 py-4 bg-gray-100 border-r overflow-auto">
      <nav class="mt-8">
        <h2 class="text-xs font-semibold text-gray-600 uppercase tracking-wide mb-2">Orders</h2>

        <div class="mt-2 -mx-3">
          <a href="#" class="flex items-center justify-between px-3 py-2 bg-gray-200 rounded-lg">
            <span class="text-sm font-medium text-gray-900">All</span>
            <span class="text-sm font-semibold text-gray-700"><%= @all %></span>
          </a>

          <a href="#" class="flex items-center justify-between px-3 py-2 bg-gray-200 rounded-lg mt-2">
            <span class="text-sm font-medium text-gray-900">Not Started</span>
            <span class="text-sm font-semibold text-gray-700"><%= @not_started %></span>
          </a>

          <a href="#" class="flex items-center justify-between px-3 py-2 bg-gray-200 rounded-lg mt-2">
            <span class="text-sm font-medium text-gray-900">Received</span>
            <span class="text-sm font-semibold text-gray-700"><%= @received %></span>
          </a>

          <a href="#" class="flex items-center justify-between px-3 py-2 bg-gray-200 rounded-lg mt-2">
            <span class="text-sm font-medium text-gray-900">Preparing</span>
            <span class="text-sm font-semibold text-gray-700"><%= @preparing %></span>
          </a>

          <a href="#" class="flex items-center justify-between px-3 py-2 bg-gray-200 rounded-lg mt-2">
            <span class="text-sm font-medium text-gray-900">Delivering</span>
            <span class="text-sm font-semibold text-gray-700"><%= @delivering %></span>
          </a>

          <a href="#" class="flex items-center justify-between px-3 py-2 bg-gray-200 rounded-lg mt-2">
            <span class="text-sm font-medium text-gray-900">Delivered</span>
            <span class="text-sm font-semibold text-gray-700"><%= @delivered %></span>
          </a>
        </div>
      </nav>
    </div>
    """
  end
end
