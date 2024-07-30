defmodule TeacherWeb.WidgetLive.Show do
  use TeacherWeb, :live_view

  alias Teacher.Products

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_info(:purchase_ok, socket) do
    socket = put_flash(socket, :info, "You bought a widget")
    {:noreply, socket}
  end
  def handle_info(:purchase_error, socket) do
    socket = put_flash(socket, :error, "This widget is sold out")
    {:noreply, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    widget = Products.get_widget!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:price, format_price(widget))
     |> assign(:widget, widget)}
  end

  defp format_price(widget) do
    widget.price / 100
  end

  defp page_title(:show), do: "Show Widget"
end
