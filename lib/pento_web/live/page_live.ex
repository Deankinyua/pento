defmodule PentoWeb.PageLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  # * This means our initial socket looks like this:
  #   %Socket{
  # assigns: %{
  #   query: "",
  #   results: %{}
  #   }
  #   }
end
