defmodule DeribitWeb.PageController do
  use DeribitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", yields: Deribit.Yield.all)
  end
end
