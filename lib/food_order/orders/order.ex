defmodule FoodOrder.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias FoodOrder.Accounts.User
  alias FoodOrder.Orders.Item

  @status_values ~w/NOT_STARTED RECEIVED PREPARING DELIVERING DELIVERED/a
  @fields ~w/status/a
  @required ~w/total_price total_quantity user_id address phone_number lat lng/a
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: [:id, :lat, :lng, :address, :phone_number]}
  @foreign_key_type :binary_id
  schema "orders" do
    field :address, :string
    field :phone_number, :string
    field :total_price, Money.Ecto.Amount.Type
    field :total_quantity, :integer
    field :lat, :float
    field :lng, :float
    field :status, Ecto.Enum, values: @status_values, default: :NOT_STARTED

    belongs_to :user, User
    has_many :items, Item

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, @fields ++ @required)
    |> validate_required(@required)
    |> validate_number(:total_quantity, greater_than: 0)
    |> cast_assoc(:items, with: &Item.changeset/2)
  end
end
