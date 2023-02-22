defmodule FoodOrderWeb.Middlewares.CartSession do
  import Phoenix.LiveView, only: [get_connect_params: 1, push_event: 3]
  import Phoenix.Component
  alias FoodOrder.Accounts
  alias FoodOrder.Carts

  def on_mount(:default, _, session, socket) do
    cart_id = get_connect_params(socket)["cart_id"]
    user_token = session["user_token"]

    socket =
      socket
      |> assign_user(user_token)
      |> create_cart(cart_id)

    {:cont, socket}
  end

  defp assign_user(socket, nil), do: assign(socket, :current_user, nil)

  defp assign_user(socket, user_token) do
    assign_new(socket, :current_user, fn -> Accounts.get_user_by_session_token(user_token) end)
  end

  defp create_cart(socket, cart_id) do
    current_user = socket.assigns.current_user

    cart_id = build_cart(current_user, cart_id)

    socket
    |> assign(cart_id: cart_id)
    |> push_event("create_cart_session_id", %{"cartId" => cart_id})
  end

  defp build_cart(nil, nil) do
    cart_id = Ecto.UUID.generate()
    Carts.create(cart_id)
    cart_id
  end

  defp build_cart(nil, cart_id) do
    Carts.create(cart_id)
    cart_id
  end

  defp build_cart(%{id: cart_id}, _) do
    Carts.create(cart_id)
    cart_id
  end
end
