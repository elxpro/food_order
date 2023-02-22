defmodule FoodOrderWeb.Admin.OrderLive.Index do
  use FoodOrderWeb, :live_view
  alias __MODULE__.Layer
  alias __MODULE__.SideMenu

  def render(assigns) do
    ~H"""
    <div class="h-screen flex pt-2">
      <.live_component module={SideMenu} id="side-menu" />

      <div class="flex-1 flex-col min-w-0 bg-white">
        <%!-- header --%>

        <div class="flex-1">
          <main class="p-3 flex" data-role="layers">
            <.live_component module={Layer} id="NOT_STARTED" />
            <.live_component module={Layer} id="RECEIVED" />
            <.live_component module={Layer} id="PREPARING" />
            <.live_component module={Layer} id="DELIVERING" />
            <.live_component module={Layer} id="DELIVERED" />
          </main>
        </div>
      </div>
    </div>
    """
  end
end
