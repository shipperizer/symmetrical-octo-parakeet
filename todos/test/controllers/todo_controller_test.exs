defmodule Todos.TodoControllerTest do
  require Logger
  use Todos.ConnCase

  test "#index renders a list of todos" do
    conn = build_conn()
    todo = insert(:todo)

    conn = get conn, todo_path(conn, :index)

    assert json_response(conn, 200) == render_json(Todos.TodoView, "index.json", todos: [todo])
  end

  test "#show renders a single todo" do
    conn = build_conn()
    todo = insert(:todo)

    conn = get conn, todo_path(conn, :show, todo)

    assert json_response(conn, 200) == render_json(Todos.TodoView, "show.json", todo: todo)
  end

  test "#create renders the todo just created" do
    conn = build_conn()

    todo = %{title: "oh my", description: "none"} |> Poison.encode!
    IO.puts inspect(todo)
    conn = post conn, todo_path(conn, :create, todo)

    assert json_response(conn, 201) == render_json(Todos.TodoView, "create.json", todo: todo)
  end
end
