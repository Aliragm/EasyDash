defmodule EasyDashWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :easy_dash

  # CORS - DEVE SER O PRIMEIRO PLUG
  plug CORSPlug,
    origin: [
      "https://perpetual-prosperity-production.up.railway.app",
      ~r/^https?:\/\/localhost(:\d+)?$/
    ],
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
    headers: ["Authorization", "Content-Type", "Accept", "Origin", "User-Agent", "DNT", "Cache-Control", "X-Mx-ReqToken", "Keep-Alive", "X-Requested-With", "If-Modified-Since", "X-CSRF-Token"],
    expose: ["Content-Length", "Content-Range"],
    max_age: 86400,
    credentials: true

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

  plug Plug.Static,
    at: "/",
    from: :easy_dash,
    gzip: false,
    only: EasyDashWeb.static_paths()

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
