defmodule FoodOrderWeb.Admin.OrderLive.Index.Layer do
  use FoodOrderWeb, :live_component
  import Phoenix.Naming, only: [humanize: 1]

  def render(assigns) do
    ~H"""
    <div class="flex-shring-0 p-3 w-80 bg-gray-100 rounded-md m-2">
      <h3 class="text-sm font-medium text-gray-9000 uppercase"><%= humanize(@id) %></h3>

      <ul class="mt-2" id={@id}>
        - carts
      </ul>
    </div>
    """
  end
end
