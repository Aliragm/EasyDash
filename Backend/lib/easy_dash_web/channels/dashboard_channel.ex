defmodule EasyDashWeb.DashboardChannel do
  use EasyDashWeb, :channel

  def join("sensor:" <> hardware_id, _payload, socket) do
    user_id = socket.assigns.user_id

    if user_owns_sensor(user_id, hardware_id) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info({:nova_leitura, leitura}, socket) do
    push(socket, "leitura_chegou", %{
      temperatura: leitura.temperatura,
      umidade: leitura.umidade,
      sensor: leitura.sensor_id,
      hora: leitura.inserted_at
    })
    {:noreply, socket}
  end

  defp user_owns_sensor(user_id, hardware_id) do
    case EasyDash.Repo.get_by(EasyDash.Iot.Sensor, hardware_id: hardware_id, user_id: user_id) do
      nil -> false
      _ -> true
    end
  end
end
