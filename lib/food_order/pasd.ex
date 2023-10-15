defmodule FoodOrder.Pasd do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pasdf" do
    field :as, :float

    timestamps()
  end

  @doc false
  def changeset(pasd, attrs) do
    pasd
    |> cast(attrs, [:as])
    |> validate_required([:as])
  end
end
