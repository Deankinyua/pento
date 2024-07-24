defmodule Pento.Repo.Migrations.CreatePhones do
  use Ecto.Migration

  def change do
    create table(:phones) do
      add :name, :string
      add :description, :string
      add :price, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
