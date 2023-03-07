defmodule FoodOrderWeb.Admin.ProductLive.Form do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  import Phoenix.Naming, only: [humanize: 1]

  @upload_options [accept: ~w/.png .jpeg .jpg/, max_entries: 1]

  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> allow_upload(:image_url, @upload_options)}
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

        <.input field={{f, :price}} label="Price" />

        <.live_file_input upload={@uploads.image_url} />

        <div>
          Add up to <%= @uploads.image_url.max_entries %> photos
          (max <%= trunc(@uploads.image_url.max_file_size / 1_000_000) %> mb each)
        </div>

        <div :for={entry <- @uploads.image_url.entries} class="flex items-center justify-between">
          <.live_img_preview entry={entry} class="w-16 h-16" />

          <div class="flex flex-col">
            <p
              :for={err <- upload_errors(@uploads.image_url, entry)}
              class="text-red-500 flex flex-col"
            >
              <%= humanize(err) %>
            </p>
            <div class="w-full bg-gray-200 rounded-full">
              <div
                class="bg-orange-500 text-xs font-medium text-blue-100 text-center p-0.5 leading-none rounded-full"
                style={"width: #{Integer.to_string(entry.progress)}#"}
              >
                <%= entry.progress %>
              </div>
            </div>
          </div>

          <button phx-click="cancel" phx-target={@myself} phx-value-ref={entry.ref}>
            <Heroicons.x_mark outline class="h-5 w-5 text-red-500 stroke-current" />
          </button>
        </div>

        <:actions>
          <.button phx-disable-with="Saving...">Save Product</.button>
        </:actions>
      </.simple_form>
    </div>
    """
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
        socket =
          socket
          |> put_flash(:info, message)
          |> push_navigate(to: socket.assigns.navigate)

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
