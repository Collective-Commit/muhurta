defmodule MuhurtaWeb.Events.EventCreateLiveTest do
  use MuhurtaWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Muhurta.AccountsFixtures
  import Muhurta.EventsFactory

  @uuid_regex "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}"

  describe "/events/new" do
    test "renders event form page", %{conn: conn} do
      {:ok, _lv, html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/events/new")

      assert html =~ "New Event"
      assert html =~ "Save"
    end

    test "redirect to event page after saving new event", %{conn: conn} do
      {:ok, lv, _html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/events/new")

      lv
      |> form("#event-form", event: %{name: "Awesome event!", description: "Lorem ipsum"})
      |> render_submit()

      {path, flash} = assert_redirect(lv)

      assert path =~ ~r/events\/#{@uuid_regex}$/
      assert flash["info"] =~ ~s|Event created|
    end
  end

  describe "/events/mine" do
    test "deny if not logged in", %{conn: conn} do
      {:error, {:redirect, %{to: path, flash: flash}}} =
        conn
        |> live(~p"/events/mine")

      assert path == "/auth/users/log_in"
      assert flash["error"] =~ "You must log in to access this page"
    end

    test "lists my events", %{conn: conn} do
      user = user_fixture()
      event = event_fixture!(actor: user)

      {:ok, _lv, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/events/mine")

      assert html =~ event.name
    end

    test "doesn't show events by other users", %{conn: conn} do
      user = user_fixture()
      another_user = user_fixture()
      event = event_fixture!(actor: another_user)

      {:ok, _lv, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/events/mine")

      refute html =~ event.name
    end
  end

  describe "/events/{id}" do
    test "view own unpublished event", %{conn: conn} do
      user = user_fixture()
      event = event_fixture!(actor: user)

      {:ok, _lv, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/events/#{event.event_id}")

      assert html =~ event.name
      assert html =~ event.description
    end

    test "cannot view draft event of another user", %{conn: conn} do
      user = user_fixture()
      another_user = user_fixture()
      event = event_fixture!(actor: another_user)

      assert_raise Ash.Error.Invalid, fn ->
        {:ok, _lv, _html} =
          conn
          |> log_in_user(user)
          |> live(~p"/events/#{event.event_id}")
      end
    end
  end
end
