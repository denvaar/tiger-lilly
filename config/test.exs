use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tiger_lilly, TigerLillyWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tiger_lilly, TigerLilly.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "denver",
  password: "",
  database: "tiger_lilly_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
