defmodule EasyDashWeb.LeituraController do
  use EasyDashWeb, :controller

  alias EasyDash.Iot

  action_fallback EasyDashWeb.FallbackController

  def index(conn, %{"sensor_id" => sensor_id}) do
    user_id = conn.assigns[:current_user_id]
    _sensor = Iot.get_sensor_by_user!(sensor_id, user_id)
    leituras = Iot.list_leituras_by_sensor(sensor_id)
    render(conn, :index, leituras: leituras)
  end

  def index(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "O parâmetro ?sensor_id=... é obrigatório."})
  end
end
