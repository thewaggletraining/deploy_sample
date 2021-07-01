defmodule DeploySample.Repo do
  use Ecto.Repo,
    otp_app: :deploy_sample,
    adapter: Ecto.Adapters.Postgres
end
