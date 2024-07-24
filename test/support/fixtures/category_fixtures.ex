defmodule Pento.CategoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Category` context.
  """

  @doc """
  Generate a phone.
  """
  def phone_fixture(attrs \\ %{}) do
    {:ok, phone} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        price: 42
      })
      |> Pento.Category.create_phone()

    phone
  end
end
