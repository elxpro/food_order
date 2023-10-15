defmodule FoodOrderWeb.Customer.OrderLive.Status do
  use FoodOrderWeb, :live_view
  import Phoenix.Naming, only: [humanize: 1]
  alias FoodOrder.Orders
  alias FoodOrder.Orders.Events.ChangeDeliveringStatus

  def handle_params(%{"id" => id}, _, socket) do
    if connected?(socket) do
      Orders.subscribe_update_order(id)
      ChangeDeliveringStatus.subscribe(id)
    end

    current_user = socket.assigns.current_user
    order = Orders.get_order_by_id_and_customer_id(id, current_user.id)
    status_list = Orders.get_status_list()
    {:noreply, assign(socket, order: order, status_list: status_list)}
  end

  def handle_info({:update_order, order}, socket) do
    {:noreply, assign(socket, order: order)}
  end

  def handle_info({:change_delivering, deliver, deliver_old}, socket) do
    {:noreply, push_event(socket, "update-deliver-location", %{deliver: deliver, deliver_old: deliver_old})}
  end

  def get_icon(%{status: :NOT_STARTED} = assigns) do
    ~H"""
    <Heroicons.face_frown outline class="h-10 w-10 stroke-current" />
    """
  end

  def get_icon(%{status: :RECEIVED} = assigns) do
    ~H"""
    <Heroicons.receipt_percent outline class="h-10 w-10 stroke-current" />
    """
  end

  def get_icon(%{status: :PREPARING} = assigns) do
    ~H"""
    <Heroicons.building_storefront outline class="h-10 w-10 stroke-current" />
    """
  end

  def get_icon(%{status: :DELIVERING} = assigns) do
    ~H"""
    <Heroicons.truck outline class="h-10 w-10 stroke-current" />
    """
  end

  def get_icon(%{status: :DELIVERED} = assigns) do
    ~H"""
    <Heroicons.face_smile outline class="h-10 w-10 stroke-current" />
    """
  end
end
