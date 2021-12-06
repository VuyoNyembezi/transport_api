import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :transport_api, TransportApi.Repo,
  username: "postgres",
  password: "12345",
  database: "transportDB_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :transport_api, TransportApiWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "meOatyYdqZ17FvG0tMpPq8G4u3wEIsH1ogBS+Pth7Px9bwpmV6KjKYFRFTdPUhlW",
  server: false

# In test we don't send emails.
config :transport_api, TransportApi.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
