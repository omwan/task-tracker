defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string, null: false
      add :description, :string
      add :complete, :boolean, default: false, null: false
      add :time_spent, :integer
      add :user_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create index(:tasks, [:user_id])
  end
end
