defmodule FoodOrderWeb.Admin.OrderLive.Index.Layer do
  use FoodOrderWeb, :live_component
  import Phoenix.Naming, only: [humanize: 1]
  alias __MODULE__.Card

  @status [:NOT_STARTED, :DELIVERED]

  def update(assigns, socket) do
    cards = [
      %{
        id: Ecto.UUID.generate(),
        status: @status |> Enum.shuffle() |> hd(),
        user: %{email: "adm@elxpro.com"},
        total_price: Money.new(10_000),
        total_quantity: 2,
        updated_at: NaiveDateTime.utc_now(),
        items: [
          %{
            id: Ecto.UUID.generate(),
            quantity: 10,
            product: %{
              name: "pumpkin",
              price: Money.new(200)
            }
          },
          %{
            id: Ecto.UUID.generate(),
            quantity: 5,
            product: %{
              name: "waffle",
              price: Money.new(200)
            }
          }
        ]
      }
    ]

    {:ok, socket |> assign(assigns) |> assign(cards: cards)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex-shrink-0 p-3 w-80 bg-gray-100 rounded-md m-2">
      <h3 class="text-sm font-medium text-gray-9000 uppercase"><%= humanize(@id) %></h3>

      <ul class="mt-2" id={@id}>
        <.live_component :for={card <- @cards} module={Card} id={card.id} card={card} />
      </ul>
    </div>
    """
  end
end
