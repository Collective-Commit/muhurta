defmodule Muhurta.Events.Organizer do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: Muhurta.Events

  postgres do
    table "organizers"
    repo Muhurta.Repo
  end

  attributes do
    uuid_primary_key :organizer_id

    attribute :name, :string
    attribute :email, :ci_string
    attribute :contact_info, :string

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :event, Muhurta.Events.Event do
      source_attribute :organizer_id
      destination_attribute :organizer_id
    end
  end
end
