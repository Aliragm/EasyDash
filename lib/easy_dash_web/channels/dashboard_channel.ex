defmodule EasyDashWeb.DashboardChannel do
  use EasyDashWeb, :channel

  def join("dashboard:geral", _payload, socket) do
    {:ok, socket}
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
end
