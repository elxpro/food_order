defmodule FoodOrderWeb.PageLive do
  use FoodOrderWeb, :live_view

  def mount(_, _, socket) do
    {:ok, assign(socket, name: "hi")}
  end

  def render(assigns) do
    ~H"""
        <%= self() |> :erlang.pid_to_list() %>
        hi <%= @name %>
    """
  end

  def handle_info({:change_name, name}, socket) do
    {:noreply, assign(socket, name: name)}
  end

  # mount
  # handle_params
  # attach_hook - in the future
  # handle_info
  # handle_event
  # components -
end
