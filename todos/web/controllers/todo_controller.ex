defmodule Todos.TodoController do
  use Todos.Web, :controller

  alias Todos.Todo

  def index(conn, _params) do
    todos = Repo.all(Todo)
    render conn, "index.json", todos: todos
  end

  def show(conn, %{"id" => id} = _params) do
    todo = Repo.get!(Todo, id)
    render conn, "show.json", todo: todo
  end

  def create(conn, %{"title" => title, "description" => description} = _params) do
    _todo = %Todos.Todo{title: title, description: description}
    todo = Repo.insert! _todo
    conn |> put_status(:created) |> render("create.json", todo: todo)
  end

end
