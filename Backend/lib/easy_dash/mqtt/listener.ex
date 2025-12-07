defmodule EasyDash.Mqtt.Listener do
  use Tortoise.Handler

  require Logger

  def init(args) do
    Logger.info("MQTT ON...")
    {:ok, args}
  end

  def connection(_status, state) do
    {:ok, state}
  end

  def handle_message(_topic, payload, state) do
    Logger.warning("Chegou: #{inspect(payload)}")
    case Jason.decode(payload) do
      {:ok, dados} ->
        attributes = %{
          "temperatura" => dados["temperatura"],
          "umidade" => dados["umidade"],
          "sensor_id" => dados["id"]
        }
      case EasyDash.Iot.create_leitura(attributes) do
        {:ok, leitura} ->
          dinamic_topic = "sensor:#{dados["id"]}"
          Logger.info("Salvo no banco: ID #{leitura.id}")
          Phoenix.PubSub.broadcast(
            EasyDash.PubSub,
            dinamic_topic,
            {:nova_leitura, leitura}
          )
        {:error, changeset} -> Logger.error("Erro ao salvar: #{inspect(changeset.errors)}")
      end

      {:error, _} ->
        Logger.error("JSON inválido recebido: #{inspect(payload)}")
    end

    {:ok, state}
  end

  def subscription(_status, _topic_filter, state) do
    {:ok, state}
  end

  def terminate(_reason, _state) do
    :ok
  end
end
