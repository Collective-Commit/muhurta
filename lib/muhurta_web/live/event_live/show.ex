defmodule MuhurtaWeb.EventLive.Show do
  use MuhurtaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"event_id" => event_id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(
       :event,
       Ash.get!(Muhurta.Events.Event, event_id, actor: socket.assigns.current_user)
     )}
  end

  defp page_title(:show), do: "Show Event"
  defp page_title(:edit), do: "Edit Event"
end
