defmodule Muhurta.Repo do
  use Ecto.Repo,
    otp_app: :muhurta,
    adapter: Ecto.Adapters.Postgres
end
