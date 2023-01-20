defmodule FoodOrderWeb.Admin.ProductLive.Index do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Admin.ProductLive.Form

  def handle_params(params, _, socket) do
    live_action = socket.assigns.live_action
    name = params["name"] || ""
    products = Products.list_products(name: name)
    assigns = [name: name, products: products, loading: false]

    socket =
      socket
      |> apply_action(live_action, params)
      |> assign(assigns)

    {:noreply, socket}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    products = socket.assigns.products
    product = Enum.find(products, &(&1.id == id))
    Products.delete_product(product)
    delete_product = fn products -> Enum.filter(products, &(&1.id != id)) end
    {:noreply, update(socket, :products, &delete_product.(&1, id))}
  end

  def handle_event("filter_by_name", %{"name" => name}, socket) do
    socket = apply_filters(socket, name)
    {:noreply, socket}
  end

  def handle_info({:list_product, name}, socket) do
    params = [name: name]
    {:noreply, perform_filter(socket, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket |> assign(:page_title, "New Product") |> assign(:product, %Product{})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    product = Products.get_product!(id)
    socket |> assign(:page_title, "Edit Product") |> assign(:product, product)
  end

  defp apply_action(socket, :index, _params) do
    socket |> assign(:page_title, "List Products")
  end

  defp apply_filters(socket, name) do
    assigns = [products: [], name: name, loading: true]
    send(self(), {:list_product, name})
    assign(socket, assigns)
  end

  defp perform_filter(socket, params) do
    params
    |> Products.list_products()
    |> return_response(socket, params)
  end

  defp return_response([], socket, params) do
    assigns = [loading: false, products: [], name: params[:name]]

    socket
    |> put_flash(:error, "There is no product with: \"#{params[:name]}\"")
    |> assign(assigns)
  end

  defp return_response(products, socket, _params) do
    assigns = [loading: false, products: products]
    assign(socket, assigns)
  end

  def search_by_name(assigns) do
    ~H"""
    <form phx-submit="filter_by_name" class="mr-4">
      <div class="relative">
        <span class="absolute inset-y-0 pl-2 left-0 flex items-center">
          <Heroicons.magnifying_glass solid class="h-6 w-6 stroke-current" />
        </span>
        <input
          type="text"
          autocomplete="off"
          name="name"
          value={@name}
          placeholder="Search by name"
          class="pl-10 pr-4 py-4 text-gray-900 text-sm leading-tight border-gray-400 placeholder-gray-600 rounded-md border"
        />
      </div>
    </form>
    """
  end
end
