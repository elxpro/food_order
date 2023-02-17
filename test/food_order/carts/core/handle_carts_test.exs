defmodule FoodOrder.Carts.Core.HandleCartsTest do
  use FoodOrder.DataCase

  import FoodOrder.ProductsFixtures
  import FoodOrder.Carts.Core.HandleCarts

  alias FoodOrder.Carts.Data.Cart

  @start_cart %Cart{
    id: 444_444,
    items: [],
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
      assert [%{item: product, qty: 1}] == cart.items
      assert product.price == cart.total_price
    end

    test "add the same item twice" do
      product = product_fixture()
      cart = @start_cart |> add(product) |> add(product)

      assert 2 == cart.total_qty
      assert Money.add(product.price, product.price) == cart.total_price
      assert [%{item: product, qty: 2}] == cart.items
    end
  end
end
