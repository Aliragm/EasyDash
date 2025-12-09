import Config

# Força o servidor a iniciar em produção
if config_env() == :prod do
  config :easy_dash, EasyDashWeb.Endpoint, server: true
end

# --- CONFIGURAÇÃO DO BANCO DE DADOS ---
database_url = System.get_env("DATABASE_URL")
db_host = System.get_env("DB_HOST")

if database_url do
  config :easy_dash, EasyDash.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    ssl: true,
    ssl_opts: [
      verify: :verify_none
    ]
else
  if db_host do
    config :easy_dash, EasyDash.Repo,
      username: System.get_env("DB_USER") || "postgres",
      password: System.get_env("DB_PASS") || "postgres",
      hostname: db_host,
      database: System.get_env("DB_NAME") || "easy_db",
      pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
  end
end

# --- CONFIGURAÇÃO DE PRODUÇÃO ---
if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :easy_dash, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  config :easy_dash, EasyDashWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base,
    check_origin: false,
    server: true
end
