defmodule TaskTracker.Repo.Migrations.UpdateUsersManagers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :manager_id, references(:users, on_delete: :nilify_all)
    end
  end
end
