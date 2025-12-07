defmodule EasyDash.Repo.Migrations.CreateLeituras do
  use Ecto.Migration

  def change do
    create table(:leituras) do
      add :temperatura, :float
      add :umidade, :float
      add :sensor_id, :string

      timestamps(type: :utc_datetime)
    end
  end
end
