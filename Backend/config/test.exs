import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :easy_dash, EasyDash.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "easy_dash_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :easy_dash, EasyDashWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "bIeMk1kneGpyiNZiSl1H8cjofAekezXFO/RKVnY8J1yt2P01WyzepmOWN5p4UkUq",
  server: false

# In test we don't send emails
config :easy_dash, EasyDash.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
