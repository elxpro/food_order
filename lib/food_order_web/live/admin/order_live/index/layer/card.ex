defmodule FoodOrderWeb.Admin.OrderLive.Index.Layer.Card do
  use FoodOrderWeb, :live_component

  def render(assigns) do
    ~H"""
    <li id={@id} class="block p-5 mb-5 bg-white rounded-md shadow">
      <a href="#">
        <div class="flex-justify-between mb-2">
          <p class="text-xs font-medium leading snug text-gray-900"><%= @id %></p>
          <Heroicons.shopping_bag solid class="w-8 h-8 rounded-full mx-auto text-orange-500" />
        </div>

        <hr />

        <div>
          <p class="text-sm p-2 font-medium leading-snug text-gray-900">Order Items</p>

          <ul>
            <li :for={item <- @card.items} class="text-sm mb-1 flex justify-between">
              <span><%= item.product.name %></span>
              <span><%= item.product.price %></span>
            </li>
          </ul>
        </div>

        <hr />

        <div>
          <p class="text-sm p-2 font-medium leading-snug text-gray-900">Order description</p>

          <ul class="text-xs">
            <li class="flex justify-between mb-1">
              <span>Total Price:</span>
              <span><%= @card.total_price %></span>
            </li>
            <li class="flex justify-between mb-1">
              <span>Total Quantity:</span>
              <span><%= @card.total_quantity %></span>
            </li>
            <li class="flex justify-between mb-1">
              <span>Customer:</span>
              <span><%= @card.user.email %></span>
            </li>

            <li :if={@card.status == :DELIVERED} class="flex justify-between mb-1">
              <span class="text-orange-500">Delivered at:</span>
              <span class="font-bold"><%= @card.updated_at %></span>
            </li>
          </ul>
        </div>
      </a>
    </li>
    """
  end
end
