defmodule TaskTracker.Repo.Migrations.CreateTimeBlock do
  use Ecto.Migration

  def change do
    create table(:time_block) do
      add :start, :utc_datetime, null: false
      add :stop, :utc_datetime, null: false
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:time_block, [:task_id])
  end
end
