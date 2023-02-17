defmodule FoodOrder.Carts.Core.HandleCartsTest do
  use FoodOrder.DataCase

  import FoodOrder.ProductsFixtures
  import FoodOrder.Carts.Core.HandleCarts

  alias FoodOrder.Carts.Data.Cart

  @start_cart %Cart{
    id: 444_444,
    items: [],
    total_items: 0,
    total_price: %Money{amount: 0, currency: :USD},
    total_qty: 0
  }

  describe "cart" do
    test "create new cart" do
      assert @start_cart == create(444_444)
    end
  end

  describe "add" do
    test "add new item in the cart" do
      product = product_fixture()

      cart = add(@start_cart, product)

      assert 1 == cart.total_qty
      assert [product] == cart.items
      assert product.price == cart.total_price
      assert 1 == cart.total_items
    end
  end
end
