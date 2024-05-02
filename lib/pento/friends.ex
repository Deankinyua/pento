defmodule Pento.Friend do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pento.Friend

  schema "friends" do
    field(:about, :string)
    field(:birthdate, :date, virtual: true)
    field(:email, :string)
    field(:friendname, :string)

    timestamps()
  end

  def changeset(%Friend{} = friend, attrs) do
    friend
    |> cast(attrs, [:friendname, :email, :birthdate, :about])
    |> validate_required([[:friendname, :email, :birthdate]])
    |> validate_length(:friendname, min: 3)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:friendname)
  end
end

# bob = %User{username: "bob"}
