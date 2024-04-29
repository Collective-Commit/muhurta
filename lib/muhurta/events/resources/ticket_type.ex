defmodule Muhurta.Events.TicketType do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: Muhurta.Events

  postgres do
    table "ticket_types"
    repo Muhurta.Repo
  end

  attributes do
    uuid_primary_key :ticket_type_id

    attribute :type, :string
    attribute :description, :string
    attribute :price, AshMoney.Types.Money
    attribute :quantity, :integer

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :event, Muhurta.Events.Event do
      source_attribute :event_id
      destination_attribute :event_id
    end
  end
end
