defmodule FoodOrder.CartsTest do
  use FoodOrder.DataCase
  import FoodOrder.Carts

  describe "session" do
    test "create session" do
      assert create_session(444) == :ok
    end
  end
end
