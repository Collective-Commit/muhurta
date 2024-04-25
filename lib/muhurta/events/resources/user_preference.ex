defmodule Muhurta.Events.UserPreference do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: Muhurta.Events

  postgres do
    table "user_preferences"
    repo Muhurta.Repo
  end

  attributes do
    uuid_primary_key :user_preference_id
    attribute :timezon, :string

    create_timestamp :created_at
    update_timestamp :updated_at
  end
end
