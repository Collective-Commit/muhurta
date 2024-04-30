defmodule Muhurta.EventsFactory do
  import Muhurta.AccountsFixtures

  def event_fixture!(attrs \\ []) do
    {actor, attrs} = Keyword.pop(attrs, :actor, user_fixture())

    attrs =
      Keyword.merge(
        [
          name: Faker.Lorem.sentence(3..5),
          description: Enum.join(Faker.Lorem.paragraphs(3))
        ],
        attrs
      )

    attrs
    |> Muhurta.Events.create_draft_event!(actor: actor)
  end
end
