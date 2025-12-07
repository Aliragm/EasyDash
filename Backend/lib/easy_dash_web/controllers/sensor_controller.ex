defmodule EasyDashWeb.SensorController do
  use EasyDashWeb, :controller

  alias EasyDash.Iot
  alias EasyDash.Iot.Sensor

  action_fallback EasyDashWeb.FallbackController

  def index(conn, _params) do
    user_id = conn.assigns[:current_user_id]

    sensors = Iot.list_sensors_by_user(user_id)
    render(conn, :index, sensors: sensors)
  end

  def create(conn, %{"sensor" => sensor_params}) do
    user_id = conn.assigns[:current_user_id]

    params_with_owner = Map.put(sensor_params, "user_id", user_id)

    with  {:ok, %Sensor{} = sensor}<- Iot.create_sensor(params_with_owner)  do
      conn
      |> put_status(:created)
      |> render(:show, sensor: sensor)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns[:current_user_id]
    sensor = EasyDash.Repo.get_by!(Sensor, id: id, user_id: user_id)

    with {:ok, %Sensor{}}<- Iot.delete_sensor(sensor) do
      send_resp(conn, :no_content, "")
    end
  end
end
