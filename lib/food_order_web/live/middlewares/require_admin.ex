defmodule FoodOrderWeb.RequireAdmin do
  use FoodOrderWeb, :html

  def on_mount(_default, _params, _session, socket) do
    current_user = socket.assigns.current_user

    if current_user.role == :ADMIN do
      {:cont, socket}
    else
      {:halt,
       socket
       |> Phoenix.LiveView.put_flash(:error, "You must be admin to access this page!")
       |> Phoenix.LiveView.redirect(to: ~p"/")}
    end
  end
end
