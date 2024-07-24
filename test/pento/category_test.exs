defmodule Pento.CategoryTest do
  use Pento.DataCase

  alias Pento.Category

  describe "phones" do
    alias Pento.Category.Phone

    import Pento.CategoryFixtures

    @invalid_attrs %{name: nil, description: nil, price: nil}

    test "list_phones/0 returns all phones" do
      phone = phone_fixture()
      assert Category.list_phones() == [phone]
    end

    test "get_phone!/1 returns the phone with given id" do
      phone = phone_fixture()
      assert Category.get_phone!(phone.id) == phone
    end

    test "create_phone/1 with valid data creates a phone" do
      valid_attrs = %{name: "some name", description: "some description", price: 42}

      assert {:ok, %Phone{} = phone} = Category.create_phone(valid_attrs)
      assert phone.name == "some name"
      assert phone.description == "some description"
      assert phone.price == 42
    end

    test "create_phone/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Category.create_phone(@invalid_attrs)
    end

    test "update_phone/2 with valid data updates the phone" do
      phone = phone_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        price: 43
      }

      assert {:ok, %Phone{} = phone} = Category.update_phone(phone, update_attrs)
      assert phone.name == "some updated name"
      assert phone.description == "some updated description"
      assert phone.price == 43
    end

    test "update_phone/2 with invalid data returns error changeset" do
      phone = phone_fixture()
      assert {:error, %Ecto.Changeset{}} = Category.update_phone(phone, @invalid_attrs)
      assert phone == Category.get_phone!(phone.id)
    end

    test "delete_phone/1 deletes the phone" do
      phone = phone_fixture()
      assert {:ok, %Phone{}} = Category.delete_phone(phone)
      assert_raise Ecto.NoResultsError, fn -> Category.get_phone!(phone.id) end
    end

    test "change_phone/1 returns a phone changeset" do
      phone = phone_fixture()
      assert %Ecto.Changeset{} = Category.change_phone(phone)
    end
  end
end
