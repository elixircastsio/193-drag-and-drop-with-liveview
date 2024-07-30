defmodule TeacherWeb.WidgetLive.OrderComponent do
  use TeacherWeb, :live_component

  alias Teacher.Purchaser

  @impl true
  def update(assigns, socket) do
    socket =
      socket
      |> assign(:id, assigns.id)
      |> assign(:widget_id, assigns.widget_id)
      |> assign(:quantity, assigns[:quantity] || 1)

    {:ok, socket}
  end

  @impl true
  def handle_event("buy", _params, socket) do
    quantity = socket.assigns.quantity
    widget_id = socket.assigns.widget_id
    case Purchaser.purchase(widget_id, quantity) do
      :ok ->
        send(self(), :purchase_ok)
      :error ->
        send(self(), :purchase_error)
    end

    {:noreply, socket}
  end
  def handle_event("increment", _params, socket) do
    {:noreply, assign(socket, :quantity, socket.assigns.quantity + 1)}
  end
  def handle_event("decrement", _params, socket) do
    quantity = socket.assigns.quantity
    new_quantity =
      if quantity == 1 do
        1
      else
        quantity - 1
      end

    {:noreply, assign(socket, :quantity, new_quantity)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id} class="flex items-center space-x-2">
      <div class="relative">
        <input type="number" value={@quantity} class="border-2 border-gray-300 text-center w-20 h-10 rounded-md text-sm" />
        <div class="absolute inset-y-0 right-0 flex items-center px-2">
          <div class="flex flex-col text-gray-700">
            <button phx-click="increment" phx-target={@myself} class="hover:bg-gray-200 h-1/2">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path></svg>
            </button>
            <button phx-click="decrement" phx-target={@myself} class="hover:bg-gray-200 h-1/2">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
            </button>
          </div>
        </div>
      </div>
      <button phx-click="buy" phx-target={@myself} class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Buy
      </button>
    </div>
    """
  end

end
