defmodule Muhurta.Events.Event do
  @derive {Phoenix.Param, key: :event_id}

  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: Muhurta.Events,
    authorizers: [Ash.Policy.Authorizer]

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

    attribute :is_published, :boolean do
      default false
    end

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

  actions do
    defaults [:read, :destroy, create: :*, update: :*]

    create :draft_event do
      accept [:name, :description]

      validate present(:name), message: "Name of the event is missing"
      validate present(:description), message: "Description of the event is missing"

      change set_attribute(:user_id, actor(:user_id))
    end

    read :mine do
      filter expr(user_id == ^actor(:user_id))
    end
  end

  policies do
    bypass relates_to_actor_via(:creator) do
      authorize_if always()
    end

    policy action(:read) do
      forbid_if expr(is_published == false)
    end

    policy always() do
      authorize_if always()
    end
  end
end
