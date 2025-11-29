defmodule EasyDashWeb.LeituraController do
  use EasyDashWeb, :controller

  alias EasyDash.Iot
  alias EasyDash.Iot.Leitura

  action_fallback EasyDashWeb.FallbackController

  def index(conn, %{"sensor_id" => sensor_id}) do
    leituras = Iot.list_leituras_por_sensor(sensor_id)
    render(conn, :index, leituras: leituras)
  end

  def index(conn, _params) do
    leituras = Iot.list_leituras()
    render(conn, :index, leituras: leituras)
  end

  def create(conn, %{"leitura" => leitura_params}) do
    with {:ok, %Leitura{} = leitura} <- Iot.create_leitura(leitura_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/leituras/#{leitura}")
      |> render(:show, leitura: leitura)
    end
  end

  def show(conn, %{"id" => id}) do
    leitura = Iot.get_leitura!(id)
    render(conn, :show, leitura: leitura)
  end

  def update(conn, %{"id" => id, "leitura" => leitura_params}) do
    leitura = Iot.get_leitura!(id)

    with {:ok, %Leitura{} = leitura} <- Iot.update_leitura(leitura, leitura_params) do
      render(conn, :show, leitura: leitura)
    end
  end

  def delete(conn, %{"id" => id}) do
    leitura = Iot.get_leitura!(id)

    with {:ok, %Leitura{}} <- Iot.delete_leitura(leitura) do
      send_resp(conn, :no_content, "")
    end
  end
end
