defmodule Admin.Token do
  use Admin.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:info, "You must be signed in to access this page")
    |> redirect(to: homepage_path(conn, :index))
  end
  def unauthorized(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in to access this page")
    |> redirect(to: homepage_path(conn, :index))
  end
end
