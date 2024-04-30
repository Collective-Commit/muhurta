defmodule Muhurta.EventsTest do
  use Muhurta.DataCase

  alias Muhurta.Events
  import Muhurta.AccountsFixtures

  describe "events" do
    test "create_draft_event/1 with valid data creates draft event" do
      assert {:ok, created_event} =
               Events.create_draft_event(%{name: "hello", description: "some event"},
                 actor: user_fixture()
               )

      assert created_event.name == "hello"
      assert created_event.description == "some event"
      refute created_event.is_published
    end

    test "create_draft_event/1 with invalid data creates error changeset" do
      assert {:error, _changeset} = Events.create_draft_event(%{})
    end
  end
end
