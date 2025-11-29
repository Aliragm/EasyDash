defmodule EasyDashWeb.LeituraJSON do
  alias EasyDash.Iot.Leitura

  @doc """
  Renders a list of leituras.
  """
  def index(%{leituras: leituras}) do
    %{data: for(leitura <- leituras, do: data(leitura))}
  end

  @doc """
  Renders a single leitura.
  """
  def show(%{leitura: leitura}) do
    %{data: data(leitura)}
  end

  defp data(%Leitura{} = leitura) do
    %{
      id: leitura.id,
      temperatura: leitura.temperatura,
      umidade: leitura.umidade,
      sensor_id: leitura.sensor_id,
      data_hora: leitura.inserted_at
    }
  end
end
