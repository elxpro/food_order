defmodule FoodOrder.Orders.Events.NewOrderTest do
  use FoodOrder.DataCase
  alias FoodOrder.Orders.Events.NewOrder

  test "subscribe to receive new events" do
    NewOrder.subscribe()
    assert {:messages, []} == Process.info(self(), :messages)
  end

  test "receive broadcast message" do
    NewOrder.subscribe()
    assert {:messages, []} == Process.info(self(), :messages)

    NewOrder.broadcast({:ok, %{id: 123}})

    assert {:messages, [{:new_order, order}]} = Process.info(self(), :messages)
    assert order.id == 123
  end

  test "error broadcast message" do
    NewOrder.subscribe()
    assert {:messages, []} == Process.info(self(), :messages)

    NewOrder.broadcast({:error, %{id: 123}})

    assert {:messages, []} = Process.info(self(), :messages)
  end
end
