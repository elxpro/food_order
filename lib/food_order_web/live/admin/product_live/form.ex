defmodule FoodOrderWeb.Admin.ProductLive.Form do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products

  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)
    {:ok, socket |> assign(assigns) |> assign(changeset: changeset)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        :let={f}
        for={@changeset}
        id="product-form"
        phx-change="validate"
        phx-submit="save"
        phx-target={@myself}
      >
        <.input field={{f, :name}} label="name" />
        <.input field={{f, :description}} type="textarea" label="description" />
        <.input field={{f, :price}} type="number" label="Price" />

        <:actions>
          <.button phx-disable-with="Saving...">Create Product</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    case Products.create_product(product_params) do
      {:ok, _} ->
        socket =
          socket
          |> put_flash(:info, "Product created successfully")
          |> push_navigate(to: socket.assigns.navigate)

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
