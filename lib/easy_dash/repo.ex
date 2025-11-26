defmodule EasyDash.Repo do
  use Ecto.Repo,
    otp_app: :easy_dash,
    adapter: Ecto.Adapters.Postgres
end
