defmodule FoodOrderWeb.Customer.OrderLive.Status do
  use FoodOrderWeb, :live_view
  import Phoenix.Naming, only: [humanize: 1]
  alias FoodOrder.Orders

  def handle_params(%{"id" => id}, _, socket) do
    current_user = socket.assigns.current_user
    order = Orders.get_order_by_id_and_customer_id(id, current_user.id)
    status_list = Orders.get_status_list()
    {:noreply, assign(socket, order: order, status_list: status_list)}
  end

  def get_icon(%{status: :NOT_STARTED} = assigns) do
    ~H"""
      <Heroicons.no_symbol  outline class={["h-10 w-10 stroke-current"]}/>
    """
  end

  def get_icon(%{status: :RECEIVED} = assigns) do
    ~H"""
      <Heroicons.receipt_percent  outline class={["h-10 w-10 stroke-current"]}/>
    """
  end

  def get_icon(%{status: :PREPARING} = assigns) do
    ~H"""
      <Heroicons.arrow_path  outline class={["h-10 w-10 stroke-current"]}/>
    """
  end

  def get_icon(%{status: :DELIVERING} = assigns) do
    ~H"""
      <Heroicons.home_modern  outline class={["h-10 w-10 stroke-current"]}/>
    """
  end

  def get_icon(%{status: :DELIVERED} = assigns) do
    ~H"""
      <Heroicons.check  outline class={["h-10 w-10 stroke-current"]}/>
    """
  end
end
