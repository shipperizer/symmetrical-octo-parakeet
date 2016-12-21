defmodule Admin.UserController do
  use Admin.Web, :controller

  require Logger

  alias Admin.User
  alias Admin.AMQPAdapter

  def index(conn, _params) do
    users = User |> Repo.all |> Repo.preload([:videos])
    AMQPAdapter.push(msg_polish("Index call"))
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    AMQPAdapter.push(msg_polish("New call"))
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        AMQPAdapter.push(msg_polish("User inserted", User.serialize(user)))

        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = User |> Repo.get!(User, id) |> Repo.preload([:videos])
    AMQPAdapter.push(msg_polish("Show call"))
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = User |> Repo.get!(User, id) |> Repo.preload([:videos])
    changeset = User.changeset(user)
    AMQPAdapter.push(msg_polish("Edit call"))
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = User |> Repo.get!(User, id) |> Repo.preload([:videos])
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        AMQPAdapter.push(msg_polish("User modified", User.serialize(user)))

        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = User |> Repo.get!(User, id) |> Repo.preload([:videos])

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    AMQPAdapter.push(msg_polish("User deleted", User.serialize(user)))

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  defp msg_polish(event, payload \\ %{}) do
    case Map.put(payload, :event, event) |> Poison.encode do
      {:ok, msg} ->
        msg
      {:error, _} ->
        Logger.error "shit happened"
    end
  end
end
