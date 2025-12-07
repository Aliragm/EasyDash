defmodule EasyDash.IotFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EasyDash.Iot` context.
  """

  @doc """
  Generate a leitura.
  """
  def leitura_fixture(attrs \\ %{}) do
    {:ok, leitura} =
      attrs
      |> Enum.into(%{
        sensor_id: "some sensor_id",
        temperatura: 120.5,
        umidade: 120.5
      })
      |> EasyDash.Iot.create_leitura()

    leitura
  end
end
