defmodule FoodOrderWeb.CartLive.Details do
  use FoodOrderWeb, :live_component
  alias __MODULE__.Item
  alias FoodOrder.Orders
  alias FoodOrder.GetAddress

  def handle_event("create_order", params, socket) do
    case Orders.create_order_by_cart(params) do
      {:ok, _order} ->
        socket =
          socket
          |> put_flash(:info, "Order created with Success")
          |> push_redirect(to: ~p"/customer/orders")

        {:noreply, socket}

      {:error, _changeset} ->
        socket =
          socket
          |> put_flash(:error, "Something went wrong, please verify your order")
          |> push_redirect(to: ~p"/cart")

        {:noreply, socket}
    end
  end

  def handle_event("get-address", params, socket) do
    {:reply, %{address: GetAddress.execute(params)}, socket}
  end
end
