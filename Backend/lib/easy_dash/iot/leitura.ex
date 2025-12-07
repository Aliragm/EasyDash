defmodule EasyDash.Iot.Leitura do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leituras" do
    field :temperatura, :float
    field :umidade, :float
    field :sensor_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(leitura, attrs) do
    leitura
    |> cast(attrs, [:temperatura, :umidade, :sensor_id])
    |> validate_required([:temperatura, :umidade, :sensor_id])
  end
end
