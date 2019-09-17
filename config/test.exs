use Mix.Config

config :ex_testing, ExTesting.Repo,
  database: "test",
  username: "test",
  password: "",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
