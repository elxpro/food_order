defmodule FoodOrderWeb.HeaderComponent do
  use FoodOrderWeb, :html

  def menu(assigns) do
    ~H"""
    <nav class="flex items-center justify-between py-4">
      <a href="/" id="logo">
        <img src={~p"/images/logo.png"} alt="" class="h-16 w-16" />
      </a>
      <ul class="flex items-center">
        <%= if @current_user do %>
          <li class="ml-6">
            <.link href={~p"/admin/products"}>Admin Products</.link>
          </li>
          <li class="ml-6">
            Admin Orders
          </li>
          <li class="ml-6">
            My Orders
          </li>
          <li class="ml-6">
            <.link href={~p"/users/settings"}>Settings</.link>
          </li>
          <li class="ml-6">
            <span class="text-orange-500"><%= @current_user.email %></span>
            <.link href={~p"/users/log_out"} method="delete">Log out</.link>
          </li>
        <% else %>
          <li class="ml-6">
            <.link href={~p"/users/register"}>Register</.link>
          </li>
          <li class="ml-6">
            <.link href={~p"/users/log_in"}>Log in</.link>
          </li>
        <% end %>
        <a
          href={~p"/cart"}
          class="ml-6 p-4 bg-orange-500 rounded-full text-neutral-100 flex group hover:text-orange-500 hover:bg-orange-100 transition"
        >
          <span class="text-xs">0</span>
          <Heroicons.shopping_cart solid class="h-5 w-5 stroke-current" />
        </a>
      </ul>
    </nav>
    """
  end
end
