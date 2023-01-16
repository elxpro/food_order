defmodule FoodOrderWeb.MountUser do
  alias FoodOrder.Accounts

  def mount_current_user(session, socket) do
    case session do
      %{"user_token" => user_token} ->
        Phoenix.Component.assign_new(socket, :current_user, fn ->
          Accounts.get_user_by_session_token(user_token)
        end)

      %{} ->
        Phoenix.Component.assign_new(socket, :current_user, fn -> nil end)
    end
  end
end
