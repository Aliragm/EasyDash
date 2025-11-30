defmodule EasyDash.Repo.Migrations.CreateSensors do
  use Ecto.Migration

  def change do
    create table(:sensors) do
      add :nome, :string
      add :hardware_id, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:sensors, [:hardware_id])
    create index(:sensors, [:user_id])
  end
end
