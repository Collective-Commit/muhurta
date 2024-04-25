defmodule Muhurta.Events.TicketPurchase do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: Muhurta.Events

  postgres do
    table "ticket_purchases"
    repo Muhurta.Repo
  end

  attributes do
    uuid_primary_key :ticket_purchase_id

    attribute :name, :string
    attribute :email, :ci_string
    attribute :contact_info, :string
    attribute :rsvp_status, :string
    attribute :rsvp_date, :utc_datetime

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :event_instance, Muhurta.Events.EventInstance do
      source_attribute :event_instance_id
      destination_attribute :event_instance_id
    end

    belongs_to :ticket_type, Muhurta.Events.TicketType do
      source_attribute :ticket_type_id
      destination_attribute :ticket_type_id
    end
  end
end
