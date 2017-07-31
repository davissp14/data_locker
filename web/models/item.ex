defmodule Datalocker.Item do
  use Datalocker.Web, :model

  schema "items" do
    field :title, :string
    field :url, :string
    field :favicon, :string
    field :type, :string

    belongs_to :locker, DataLocker.Locker

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :url, :favicon, :type])
    |> validate_required([:title, :url, :type])
  end
end
