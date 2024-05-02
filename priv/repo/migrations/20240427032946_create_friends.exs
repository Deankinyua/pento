defmodule Pento.Repo.Migrations.CreateFriends do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :about, :text
      add :email, :string
      add :friendname, :string

      timestamps()
    end

    create unique_index(:friends, [:email, :friendname])
    create unique_index(:friends, [:friendname, :friendname])
  end
end
