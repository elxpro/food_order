defmodule FoodOrderWeb.Client do
  def all do
    [
      %{
        id: Ecto.UUID.generate(),
        name: "Gus",
        value: 0
      },
      %{
        id: Ecto.UUID.generate(),
        name: "Joe",
        value: 0
      }
    ]
  end
end
