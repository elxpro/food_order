defmodule :"Elixir.FoodOrder.Repo.Migrations.Add-deliver" do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :deliver_id, references(:delivers, on_delete: :nothing, type: :binary_id)
    end
  end
end
