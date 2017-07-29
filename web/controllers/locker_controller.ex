defmodule Datalocker.LockerController do
  use Datalocker.Web, :controller

  alias Datalocker.Locker
  alias Datalocker.Item

  def index(conn, _params) do
    lockers = Repo.all(Locker)
    render(conn, "index.html", lockers: lockers)
  end

  def new(conn, _params) do
    changeset = Locker.changeset(%Locker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"locker" => locker_params}) do
    changeset = Locker.changeset(%Locker{}, locker_params)

    case Repo.insert(changeset) do
      {:ok, _locker} ->
        conn
        |> put_flash(:info, "Locker created successfully.")
        |> redirect(to: locker_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    changeset = Item.changeset(%Item{}, %{})
    locker = Repo.get!(Locker, id)
    |> Repo.preload([items: from(i in Item, order_by: [desc: i.inserted_at])])
    render(conn, "show.html", locker: locker, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    locker = Repo.get!(Locker, id)
    changeset = Locker.changeset(locker)
    render(conn, "edit.html", locker: locker, changeset: changeset)
  end

  def update(conn, %{"id" => id, "locker" => locker_params}) do
    locker = Repo.get!(Locker, id)
    changeset = Locker.changeset(locker, locker_params)

    case Repo.update(changeset) do
      {:ok, locker} ->
        conn
        |> put_flash(:info, "Locker updated successfully.")
        |> redirect(to: locker_path(conn, :show, locker))
      {:error, changeset} ->
        render(conn, "edit.html", locker: locker, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    locker = Repo.get!(Locker, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(locker)

    conn
    |> put_flash(:info, "Locker deleted successfully.")
    |> redirect(to: locker_path(conn, :index))
  end
end
