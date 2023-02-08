defmodule FoodOrderWeb.Admin.ProductLive.Index.Paginate do
  use FoodOrderWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={@id} class="flex pr-4">
      <div :if={@options.page > 1} class="h-8 w-8 mr-1 flex justify-center items center cursor-pointer">
        <.link patch={~p"/admin/products?#{Map.update(@options, :page, @options.page, &(&1 - 1))}"}>
          <Heroicons.backward solid class="h-6 w-6 text-orange-500 stroke-current" />
        </.link>
      </div>

      <div class="flex h-8 font-medium">
        <div :for={current_page <- (@options.page - 2)..(@options.page + 1)} :if={current_page > 0} class={[current_page ==  @options.page && "border-orange-500" || "border-transparent", "w-8 md:flex justify-center items-center hidden cursor-pointer leading-5 transition duration-150 ease-in border-b-2"]}>
          <.link patch={~p"/admin/products?#{Map.put(@options, :page, current_page)}"}>
            <%= current_page %>
          </.link>
        </div>
      </div>

      <div class="h-8 w-8 mr-1 flex justify-center items center cursor-pointer">
        <.link patch={~p"/admin/products?#{Map.update(@options, :page, @options.page, &(&1 + 1))}"}>
          <Heroicons.forward solid class="h-6 w-6 text-orange-500 stroke-current" />
        </.link>
      </div>
    </div>
    """
  end
end
