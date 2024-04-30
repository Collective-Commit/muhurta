defmodule Muhurta.Events do
  use Ash.Domain

  resources do
    resource Muhurta.Events.Event do
      define :create_draft_event, action: :draft_event
    end

    resource Muhurta.Events.EventInstance
    resource Muhurta.Events.TicketType
    resource Muhurta.Events.TicketPurchase
    resource Muhurta.Events.UserPreference
    resource Muhurta.Events.Organizer
    resource Muhurta.Events.Participant
    resource Muhurta.Events.User
  end
end
