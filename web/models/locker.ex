defmodule Datalocker.Locker do
  use Datalocker.Web, :model

  schema "lockers" do
    field :name, :string
    has_many :items, Datalocker.Item

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
