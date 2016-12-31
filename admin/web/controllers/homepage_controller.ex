defmodule Admin.HomepageController do
  use Admin.Web, :controller

  require Logger

  def index(conn, _params) do
    render(conn, "index.html")
  end


end
