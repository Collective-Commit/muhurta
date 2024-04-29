defmodule Muhurta.Repo do
  use AshPostgres.Repo,
    otp_app: :muhurta

  # Installs Postgres extensions that ash commonly uses
  def installed_extensions do
    ["ash-functions", AshMoney.AshPostgresExtension]
  end
end
