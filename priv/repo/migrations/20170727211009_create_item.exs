defmodule Datalocker.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :title, :string
      add :url, :string
      add :locker_id, references(:lockers)

      timestamps()
    end

  end
end
