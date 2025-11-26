defmodule EasyDash.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EasyDashWeb.Telemetry,
      EasyDash.Repo,
      {DNSCluster, query: Application.get_env(:easy_dash, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EasyDash.PubSub},
      # Start a worker by calling: EasyDash.Worker.start_link(arg)
      # {EasyDash.Worker, arg},
      # Start to serve requests, typically the last entry
      EasyDashWeb.Endpoint,
      {Tortoise.Connection, [
        client_id: "easy_dash_backend",
        server: {Tortoise.Transport.Tcp, host: "broker.hivemq.com", port: 1883},
        handler: {EasyDash.Mqtt.Listener, []},
        subscriptions: [{"sensores/#", 0}]
      ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EasyDash.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EasyDashWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
