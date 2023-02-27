defmodule FoodOrder.Orders.ListOrdersByUserId do
  import Ecto.Query
  alias FoodOrder.Orders.Order
  alias FoodOrder.Repo

  def execute(user_id) do
    Order
    |> where([o], o.user_id == ^user_id)
    |> order_by([o], desc: o.inserted_at)
    |> Repo.all()
  end
end
