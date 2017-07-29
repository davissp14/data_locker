defmodule Datalocker.Item do
  use Datalocker.Web, :model

  schema "items" do
    field :title, :string
    field :url, :string

    belongs_to :locker, DataLocker.Locker

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :url])
    |> validate_required([:title, :url])
  end
end
