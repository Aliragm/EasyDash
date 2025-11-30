defmodule EasyDash.Iot.Sensor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sensors" do
    field :nome, :string
    field :hardware_id, :string

    belongs_to :user, EasyDash.Accounts.User
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sensor, attrs) do
    sensor
    |> cast(attrs, [:nome, :hardware_id])
    |> validate_required([:nome, :hardware_id])
    |> unique_constraint(:hardware_id)
  end
end
