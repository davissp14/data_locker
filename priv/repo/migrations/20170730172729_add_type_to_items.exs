defmodule Datalocker.Repo.Migrations.AddTypeToItems do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :type, :string
    end
  end
end
