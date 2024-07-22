defmodule PentoWeb.CustomController do
  use PentoWeb, :controller

  def index(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :custom, layout: false)
  end
end
