defmodule Admin.UserController do
  use Admin.Web, :controller

  require Logger

  alias Admin.User

  def index(conn, _params) do
    users = Repo.all(User)
    amqp_push(msg_polish("Index call"))
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    amqp_push(msg_polish("New call"))
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        amqp_push(msg_polish("User inserted", User.serialize(user)))

        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    amqp_push(msg_polish("Show call"))
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    amqp_push(msg_polish("Edit call"))
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        amqp_push(msg_polish("User modified", User.serialize(user)))

        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    amqp_push(msg_polish("User deleted", User.serialize(user)))

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  defp amqp_push(event) do
    case AMQP.Connection.open(host: "localhost", port: 5672, username: "rabbit", password: "rabbit") do
      {:ok, connection} ->
        {:ok, channel} = AMQP.Channel.open(connection)
        AMQP.Queue.declare(channel, "admin-users")
        AMQP.Basic.publish(channel, "", "admin-users", event, content_type: "application/json")
        AMQP.Connection.close(connection)
      {:error, _} ->
        Logger.error "Connection to AMQP went wrong"
    end
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
