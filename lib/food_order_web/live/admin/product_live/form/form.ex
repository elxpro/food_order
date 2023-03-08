defmodule FoodOrderWeb.Admin.ProductLive.Form do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  import Phoenix.Naming, only: [humanize: 1]
  import ProductUploadConfig

  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> allow_upload(:image_url, upload_options())}
  end

  def handle_event("cancel", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image_url, ref)}
  end

  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    {[image_url | _], []} = uploaded_entries(socket, :image_url)
    image_url = get_image_url(image_url)
    product_params = Map.put(product_params, "image_url", image_url)
    save(socket, socket.assigns.action, product_params)
  end

  defp save(socket, :edit, product_params) do
    function_result = Products.update_product(socket.assigns.product, product_params)
    message = "Product updated successfully"
    perform(socket, function_result, message)
  end

  defp save(socket, :new, product_params) do
    function_result = Products.create_product(product_params)
    message = "Product created successfully"
    perform(socket, function_result, message)
  end

  defp perform(socket, function_result, message) do
    case function_result do
      {:ok, _} ->
        build_image_url(socket)

        socket =
          socket
          |> put_flash(:info, message)
          |> push_navigate(to: socket.assigns.navigate)

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp build_image_url(socket) do
    consume_uploaded_entries(socket, :image_url, &consume_entries/2)
  end
end
