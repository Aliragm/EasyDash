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

  def handle_message(topic_levels, payload, state) do
    Logger.info("Mensagem recebida no tópico [#{topic_levels}]: #{inspect(payload)}")
    {:ok, state}
  end

  def subscription(_status, _topic_filter, state) do
    {:ok, state}
  end

  def terminate(_reason, _state) do
    :ok
  end
end
