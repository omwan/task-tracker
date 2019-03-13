defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :name, :string
    field :description, :string
    field :complete, :boolean
    belongs_to :user, TaskTracker.Users.User
    has_many :time_blocks, TaskTracker.TimeBlocks.TimeBlock

    timestamps()
  end

  def validate_task_assigned_by_manager(changeset, current_user) do
    assignee_id = get_field(changeset, :user_id)

    if assignee_id do
      assignee = TaskTracker.Users.get_user!(assignee_id)
      task = TaskTracker.Tasks.get_task!(get_field(changeset, :id))
      if task.user_id == assignee_id or assignee.manager_id == current_user do
        changeset
      else
        add_error(changeset, :assignee, "Task must be assigned to an underling")
      end
    else
      changeset
    end
  end

  @doc false
  def changeset(task, attrs, current_user) do
    task
    |> cast(attrs, [:name, :description, :complete, :user_id])
    |> validate_required([:name, :complete])
    |> validate_task_assigned_by_manager(current_user)
  end
end
