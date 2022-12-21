defmodule FoodOrderWeb.PageLive.Client do
  use FoodOrderWeb, :live_component

  def update(%{name: name}, socket) do
    {:ok, update(socket, :client, &Map.put(&1, :name, name))}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def handle_event("add", _, socket) do
    {:noreply, update(socket, :client, &Map.put(&1, :value, &1.value + 1))}
  end
end
