defmodule FoodOrderWeb.Admin.OrderLive.Index do
  use FoodOrderWeb, :live_view
  alias __MODULE__.Layer
  alias __MODULE__.SideMenu
  alias FoodOrder.Orders

  def mount(_, _, socket) do
    if connected?(socket) do
      Orders.subscribe_admin_orders_update()
      Orders.subscribe_to_receive_new_orders()
    end

    {:ok, socket}
  end

  def handle_info({:order_updated, %{status: new_status}, old_status}, socket) do
    send_update(Layer, id: old_status)
    send_update(Layer, id: Atom.to_string(new_status))
    send_update(SideMenu, id: "side-menu")
    {:noreply, socket}
  end

  def handle_info({:new_order, %{status: status}}, socket) do
    send_update(Layer, id: Atom.to_string(status))
    send_update(SideMenu, id: "side-menu")
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="h-screen flex pt-2">
      <.live_component module={SideMenu} id="side-menu" />

      <div class="flex-1 flex-col min-w-0 bg-white">
        <%!-- header --%>

        <div class="flex-1">
          <main class="p-3 flex" data-role="layers">
            <.live_component module={Layer} id="NOT_STARTED" />
            <.live_component module={Layer} id="RECEIVED" />
            <.live_component module={Layer} id="PREPARING" />
            <.live_component module={Layer} id="DELIVERING" />
            <.live_component module={Layer} id="DELIVERED" />
          </main>
        </div>
      </div>
    </div>
    """
  end
end
