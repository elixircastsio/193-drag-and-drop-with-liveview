defmodule TeacherWeb.AdminLive.Index do
  use TeacherWeb, :live_view

  alias Teacher.Products

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign_widgets(socket)}
  end

  defp assign_widgets(socket) do
    socket
    |> assign(:not_sellable_widgets, Products.not_sellable_widgets())
    |> assign(:sellable_widgets, Products.sellable_widgets())
  end

end
