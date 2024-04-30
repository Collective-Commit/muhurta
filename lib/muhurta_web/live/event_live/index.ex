defmodule MuhurtaWeb.EventLive.Index do
  use MuhurtaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream_configure(:events, dom_id: &"event-#{&1.event_id}")
     |> stream(
       :events,
       Ash.read!(Muhurta.Events.Event, action: :mine, actor: socket.assigns[:current_user])
     )
     |> assign_new(:current_user, fn -> nil end)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"event_id" => event_id}) do
    socket
    |> assign(:page_title, "Edit Event")
    |> assign(
      :event,
      Ash.get!(Muhurta.Events.Event, event_id, actor: socket.assigns.current_user)
    )
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Event")
    |> assign(:event, nil)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "My Events")
    |> assign(:event, nil)
  end

  @impl true
  def handle_event("delete", %{"event_id" => event_id}, socket) do
    event = Ash.get!(Muhurta.Events.Event, event_id, actor: socket.assigns.current_user)
    Ash.destroy!(event, actor: socket.assigns.current_user)

    {:noreply, stream_delete(socket, :events, event)}
  end
end
