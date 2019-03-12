defmodule TaskTracker.Repo.Migrations.UpdateTasksTable do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      remove :time_spent
    end
  end
end
