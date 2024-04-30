defmodule Muhurta.Repo.Migrations.EventDomainUser do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:users) do
      add :name, :text
    end

    create table(:user_preferences, primary_key: false) do
      add :user_preference_id, :uuid,
        null: false,
        default: fragment("gen_random_uuid()"),
        primary_key: true

      add :timezone, :text

      add :created_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :user_id,
          references(:users,
            column: :user_id,
            name: "user_preferences_user_id_fkey",
            type: :uuid,
            prefix: "public"
          )
    end

    create table(:ticket_types, primary_key: false) do
      add :ticket_type_id, :uuid,
        null: false,
        default: fragment("gen_random_uuid()"),
        primary_key: true

      add :type, :text
      add :description, :text
      add :price, :money_with_currency
      add :quantity, :bigint

      add :created_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :event_id, :uuid
    end

    create table(:ticket_purchases, primary_key: false) do
      add :ticket_purchase_id, :uuid,
        null: false,
        default: fragment("gen_random_uuid()"),
        primary_key: true

      add :name, :text
      add :email, :citext
      add :contact_info, :text
      add :rsvp_status, :text
      add :rsvp_date, :utc_datetime

      add :created_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :user_id,
          references(:users,
            column: :user_id,
            name: "ticket_purchases_user_id_fkey",
            type: :uuid,
            prefix: "public"
          )

      add :event_instance_id, :uuid
      add :ticket_type_id, :uuid
    end

    create table(:partcipants, primary_key: false) do
      add :participant_id, :uuid,
        null: false,
        default: fragment("gen_random_uuid()"),
        primary_key: true

      add :name, :text
      add :email, :citext
      add :contact_info, :text
      add :rsvp_status, :text
      add :rsvp_date, :utc_datetime

      add :created_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :user_id,
          references(:users,
            column: :user_id,
            name: "partcipants_user_id_fkey",
            type: :uuid,
            prefix: "public"
          )

      add :event_instance_id, :uuid
      add :ticket_type_id, :uuid
    end

    create table(:organizers, primary_key: false) do
      add :organizer_id, :uuid,
        null: false,
        default: fragment("gen_random_uuid()"),
        primary_key: true

      add :name, :text
      add :email, :citext
      add :contact_info, :text

      add :created_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")
    end

    create table(:events, primary_key: false) do
      add :event_id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
    end

    alter table(:ticket_types) do
      modify :event_id,
             references(:events,
               column: :event_id,
               name: "ticket_types_event_id_fkey",
               type: :uuid,
               prefix: "public"
             )
    end

    alter table(:events) do
      add :name, :text, null: false
      add :description, :text, null: false
      add :location, :text
      add :is_recurring, :boolean
      add :recurring_rule, :text
      add :recurring_until, :utc_datetime

      add :created_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :user_id,
          references(:users,
            column: :user_id,
            name: "events_user_id_fkey",
            type: :uuid,
            prefix: "public"
          )

      add :organizer_id,
          references(:organizers,
            column: :organizer_id,
            name: "events_organizer_id_fkey",
            type: :uuid,
            prefix: "public"
          )
    end

    create table(:event_instances, primary_key: false) do
      add :event_instance_id, :uuid,
        null: false,
        default: fragment("gen_random_uuid()"),
        primary_key: true
    end

    alter table(:ticket_purchases) do
      modify :event_instance_id,
             references(:event_instances,
               column: :event_instance_id,
               name: "ticket_purchases_event_instance_id_fkey",
               type: :uuid,
               prefix: "public"
             )

      modify :ticket_type_id,
             references(:ticket_types,
               column: :ticket_type_id,
               name: "ticket_purchases_ticket_type_id_fkey",
               type: :uuid,
               prefix: "public"
             )
    end

    alter table(:partcipants) do
      modify :event_instance_id,
             references(:event_instances,
               column: :event_instance_id,
               name: "partcipants_event_instance_id_fkey",
               type: :uuid,
               prefix: "public"
             )

      modify :ticket_type_id,
             references(:ticket_types,
               column: :ticket_type_id,
               name: "partcipants_ticket_type_id_fkey",
               type: :uuid,
               prefix: "public"
             )
    end

    alter table(:event_instances) do
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :location_override, :text

      add :created_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :event_id,
          references(:events,
            column: :event_id,
            name: "event_instances_event_id_fkey",
            type: :uuid,
            prefix: "public"
          )
    end
  end

  def down do
    drop constraint(:event_instances, "event_instances_event_id_fkey")

    alter table(:event_instances) do
      remove :event_id
      remove :updated_at
      remove :created_at
      remove :location_override
      remove :end_time
      remove :start_time
    end

    drop constraint(:partcipants, "partcipants_event_instance_id_fkey")

    drop constraint(:partcipants, "partcipants_ticket_type_id_fkey")

    alter table(:partcipants) do
      modify :ticket_type_id, :uuid
      modify :event_instance_id, :uuid
    end

    drop constraint(:ticket_purchases, "ticket_purchases_event_instance_id_fkey")

    drop constraint(:ticket_purchases, "ticket_purchases_ticket_type_id_fkey")

    alter table(:ticket_purchases) do
      modify :ticket_type_id, :uuid
      modify :event_instance_id, :uuid
    end

    drop table(:event_instances)

    drop constraint(:events, "events_user_id_fkey")

    drop constraint(:events, "events_organizer_id_fkey")

    alter table(:events) do
      remove :organizer_id
      remove :user_id
      remove :updated_at
      remove :created_at
      remove :recurring_until
      remove :recurring_rule
      remove :is_recurring
      remove :location
      remove :description
      remove :name
    end

    drop constraint(:ticket_types, "ticket_types_event_id_fkey")

    alter table(:ticket_types) do
      modify :event_id, :uuid
    end

    drop table(:events)

    drop table(:organizers)

    drop constraint(:partcipants, "partcipants_user_id_fkey")

    drop table(:partcipants)

    drop constraint(:ticket_purchases, "ticket_purchases_user_id_fkey")

    drop table(:ticket_purchases)

    drop table(:ticket_types)

    drop constraint(:user_preferences, "user_preferences_user_id_fkey")

    drop table(:user_preferences)

    drop table(:users)
  end
end