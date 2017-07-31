defmodule Datalocker.Repo.Migrations.AddFaviconToItems do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :favicon, :string
    end
  end
end
