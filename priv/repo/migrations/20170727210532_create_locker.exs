defmodule Datalocker.Repo.Migrations.CreateLocker do
  use Ecto.Migration

  def change do
    create table(:lockers) do
      add :name, :string

      timestamps()
    end

  end
end
