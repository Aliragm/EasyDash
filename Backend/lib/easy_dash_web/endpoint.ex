defmodule EasyDashWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :easy_dash

  # --- A SOLUÇÃO "BALA DE PRATA" ---
  # O CORS deve ser o primeiro porteiro, antes de qualquer outra coisa.
  plug CORSPlug,
    origin: ["*"],
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
  # ---------------------------------

  # Definição das opções de sessão (movi para cima para organizar)
  @session_options [
    store: :cookie,
    key: "_easy_dash_key",
    signing_salt: "VBHUUfo+",
    same_site: "Lax"
  ]

  socket "/socket", EasyDashWeb.UserSocket,
    websocket: true,
    longpoll: false

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  plug Plug.Static,
    at: "/",
    from: :easy_dash,
    gzip: not code_reloading?,
    only: EasyDashWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :easy_dash
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options

  plug EasyDashWeb.Router
end
