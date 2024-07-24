defmodule Pento.Category.Phone do
  use Ecto.Schema
  import Ecto.Changeset

  schema "phones" do
    field :name, :string
    field :description, :string
    field :price, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(phone, attrs) do
    phone
    |> cast(attrs, [:name, :description, :price])
    |> validate_required([:name, :description, :price])
  end
end
