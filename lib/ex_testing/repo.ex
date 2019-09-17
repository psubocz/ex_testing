defmodule ExTesting.Repo do
  use Ecto.Repo,
    otp_app: :ex_testing,
    adapter: Ecto.Adapters.Postgres
end
