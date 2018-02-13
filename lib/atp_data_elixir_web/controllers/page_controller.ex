defmodule AtpDataElixirWeb.PageController do
  use AtpDataElixirWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
