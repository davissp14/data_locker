defmodule Datalocker.LockerTest do
  use Datalocker.ModelCase

  alias Datalocker.Locker

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Locker.changeset(%Locker{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Locker.changeset(%Locker{}, @invalid_attrs)
    refute changeset.valid?
  end
end
