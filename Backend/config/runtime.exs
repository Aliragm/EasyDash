import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts.

if System.get_env("PHX_SERVER") do
  config :easy_dash, EasyDashWeb.Endpoint, server: true
end

# --- CONFIGURAÇÃO DO BANCO DE DADOS (UNIVERSAL) ---
database_url = System.get_env("DATABASE_URL")
db_host = System.get_env("DB_HOST")

if database_url do
  # CASO 1: Railway (ou Prod) mandou a URL completa
  config :easy_dash, EasyDash.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
    # socket_options: if(System.get_env("ECTO_IPV6") in ~w(true 1), do: [:inet6], else: [])

else
  # Se não tem URL, verificamos se tem as variáveis do Docker Local
  if db_host do
    # CASO 2: Docker Local (Docker Compose)
    config :easy_dash, EasyDash.Repo,
      username: System.get_env("DB_USER") || "postgres",
      password: System.get_env("DB_PASS") || "postgres",
      hostname: db_host,
      database: System.get_env("DB_NAME") || "easy_db",
      pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
  end
end

# --- CONFIGURAÇÃO ESPECÍFICA DE PRODUÇÃO ---
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
    secret_key_base: secret_key_base
end
