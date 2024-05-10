defmodule MuhurtaWeb.EventLive.FormComponent do
  use MuhurtaWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage event records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="event-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input type="text" label="Name" field={@form[:name]} />
        <.input type="text" label="Description" field={@form[:description]} />

        <:actions>
          <.button phx-disable-with="Saving...">Save Event</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form()}
  end

  @impl true
  def handle_event("validate", %{"event" => event_params}, socket) do
    {:noreply, assign(socket, form: AshPhoenix.Form.validate(socket.assigns.form, event_params))}
  end

  def handle_event("save", %{"event" => event_params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: event_params) do
      {:ok, event} ->
        socket =
          socket
          |> put_flash(:info, "Event #{socket.assigns.form.source.type}d successfully")
          |> redirect(to: ~p"/events/#{event.event_id}")

        {:noreply, socket}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  defp assign_form(%{assigns: %{event: event}} = socket) do
    form =
      if event do
        AshPhoenix.Form.for_update(event, :update,
          as: "event",
          actor: socket.assigns.current_user
        )
      else
        AshPhoenix.Form.for_create(Muhurta.Events.Event, :draft_event,
          as: "event",
          actor: socket.assigns.current_user
        )
      end

    assign(socket, form: to_form(form))
  end
end
