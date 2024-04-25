defmodule Muhurta.Events.EventInstance do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: Muhurta.Events

  postgres do
    table "event_instances"
    repo Muhurta.Repo
  end

  attributes do
    uuid_primary_key :event_instance_id

    attribute :start_time, :utc_datetime
    attribute :end_time, :utc_datetime
    attribute :location_override, :string

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :event, Muhurta.Events.Event do
      source_attribute :event_id
      destination_attribute :event_id
    end

    has_many :participants, Muhurta.Events.Participant do
      source_attribute :event_instance_id
      destination_attribute :event_instance_id
    end
  end
end
