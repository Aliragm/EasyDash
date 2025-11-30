defmodule EasyDashWeb.SensorJSON do
  alias EasyDash.Iot.Sensor

  def index(%{sensors: sensors}) do
    %{data: for(sensor <- sensors, do: data(sensor))}
  end

  def show(%{sensor: sensor}) do
    %{data: data(sensor)}
  end

  defp data(%Sensor{} = sensor) do
    %{
      id: sensor.id,
      name: sensor.name,
      hardware_id: sensor.hardware_id,
      user_id: sensor.user_id
    }
  end
end
