defmodule B1Web.PageController do
  use B1Web, :controller

  # "action" is the name for functions that handle requests. always take those 2 params.
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
