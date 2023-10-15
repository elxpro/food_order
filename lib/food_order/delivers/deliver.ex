defmodule FoodOrder.Delivers.Deliver do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "delivers" do
    field :lat, :float
    field :lng, :float
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(deliver, attrs) do
    deliver
    |> cast(attrs, [:name, :lat, :lng])
    |> validate_required([:name, :lat, :lng])
  end
end
