defmodule Muhurta.Events.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    domain: Muhurta.Events

  postgres do
    table "users"
    repo Muhurta.Repo
  end

  attributes do
    uuid_primary_key :user_id

    attribute :name, :string
    attribute :email, :string
  end
end
