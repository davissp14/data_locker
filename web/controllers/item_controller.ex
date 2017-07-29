defmodule Datalocker.ItemController do
  use Datalocker.Web, :controller

  alias Datalocker.Item
  alias Datalocker.Locker

  def index(conn, _params) do
    items = Repo.all(Item)
    render(conn, "index.html", items: items)
  end

  def new(conn, params) do
    changeset = Item.changeset(%Item{})
    locker = Repo.get!(Locker, params["locker_id"])
    render(conn, "new.html", changeset: changeset, locker: locker)
  end

  def create(conn, %{"item" => item_params, "locker_id" => locker_id}) do
    changeset = Item.changeset(%Item{locker_id: String.to_integer(locker_id)}, item_params)

    case Repo.insert(changeset) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: locker_path(conn, :show, locker_id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
    changeset = Item.changeset(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Repo.get!(Item, id)
    changeset = Item.changeset(item, item_params)

    case Repo.update(changeset) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: locker_path(conn, :show, item))
      {:error, changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "locker_id" => locker_id}) do
    item = Repo.get!(Item, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: locker_path(conn, :show, locker_id))
  end
end
