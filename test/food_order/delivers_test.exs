defmodule FoodOrder.DeliversTest do
  use FoodOrder.DataCase

  alias FoodOrder.Delivers

  describe "delivers" do
    alias FoodOrder.Delivers.Deliver

    import FoodOrder.DeliversFixtures

    @invalid_attrs %{lat: nil, lng: nil, name: nil}

    test "list_delivers/0 returns all delivers" do
      deliver = deliver_fixture()
      assert Delivers.list_delivers() == [deliver]
    end

    test "get_deliver!/1 returns the deliver with given id" do
      deliver = deliver_fixture()
      assert Delivers.get_deliver!(deliver.id) == deliver
    end

    test "create_deliver/1 with valid data creates a deliver" do
      valid_attrs = %{lat: 120.5, lng: 120.5, name: "some name"}

      assert {:ok, %Deliver{} = deliver} = Delivers.create_deliver(valid_attrs)
      assert deliver.lat == 120.5
      assert deliver.lng == 120.5
      assert deliver.name == "some name"
    end

    test "create_deliver/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Delivers.create_deliver(@invalid_attrs)
    end

    test "update_deliver/2 with valid data updates the deliver" do
      deliver = deliver_fixture()
      update_attrs = %{lat: 456.7, lng: 456.7, name: "some updated name"}

      assert {:ok, %Deliver{} = deliver} = Delivers.update_deliver(deliver, update_attrs)
      assert deliver.lat == 456.7
      assert deliver.lng == 456.7
      assert deliver.name == "some updated name"
    end

    test "update_deliver/2 with invalid data returns error changeset" do
      deliver = deliver_fixture()
      assert {:error, %Ecto.Changeset{}} = Delivers.update_deliver(deliver, @invalid_attrs)
      assert deliver == Delivers.get_deliver!(deliver.id)
    end

    test "delete_deliver/1 deletes the deliver" do
      deliver = deliver_fixture()
      assert {:ok, %Deliver{}} = Delivers.delete_deliver(deliver)
      assert_raise Ecto.NoResultsError, fn -> Delivers.get_deliver!(deliver.id) end
    end

    test "change_deliver/1 returns a deliver changeset" do
      deliver = deliver_fixture()
      assert %Ecto.Changeset{} = Delivers.change_deliver(deliver)
    end
  end
end
