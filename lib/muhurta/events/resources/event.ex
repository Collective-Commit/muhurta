defmodule Muhurta.Events.Event do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: Muhurta.Events

  postgres do
    table "events"
    repo Muhurta.Repo
  end

  attributes do
    uuid_primary_key :event_id

    attribute :name, :string do
      allow_nil? false
    end

    attribute :description, :string do
      allow_nil? false
    end

    attribute :location, :string
    attribute :is_recurring, :boolean
    attribute :recurring_rule, :string
    attribute :recurring_until, :utc_datetime

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :creator, Muhurta.Events.User do
      source_attribute :user_id
      destination_attribute :user_id
    end

    belongs_to :organizer, Muhurta.Events.Organizer do
      source_attribute :organizer_id
      destination_attribute :organizer_id
    end

    has_many :instances, Muhurta.Events.EventInstance do
      source_attribute :event_id
      destination_attribute :event_id
    end
  end
end
