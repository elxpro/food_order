defmodule FoodOrderWeb.Admin.OrderLive.Index do
  use FoodOrderWeb, :live_view
  alias __MODULE__.SideMenu

  def render(assigns) do
    ~H"""
    <div class="h-screen flex pt-2">
      <.live_component module={SideMenu} id="side-menu" />
    </div>
    """
  end

end
