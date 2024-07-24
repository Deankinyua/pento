defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :unit_price, :float
    field :sku, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false

  # * Remember a changeset is never contained in a database
  # * The work of a changeset is keeping bad data from being inserted
  # * Uses the valid flag to determine whether to insert the data
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> validate_number(:unit_price, greater_than: 0.0)
    |> unique_constraint(:sku)
  end

  def changeset2(product, attrs, price) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> validate_number(:unit_price, less_than: price)
    |> unique_constraint(:sku)
  end
end
