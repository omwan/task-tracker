defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :admin, :boolean, default: false
    field :username, :string
    has_many :tasks, TaskTracker.Tasks.Task
    belongs_to :manager, TaskTracker.Users.User
    has_many :subordinates, TaskTracker.Users.User

    timestamps()
  end

  def validate_manager_is_admin(changeset) do
    manager_id = get_field(changeset, :manager_id)

    if manager_id do
      manager = TaskTracker.Users.get_user!(manager_id)
      if manager.admin do
        changeset
      else
        add_error(changeset, :manager, "Manager must be an admin")
      end
    else
      changeset
    end

  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :admin, :manager_id])
    |> validate_required([:username, :admin])
    |> validate_manager_is_admin()
  end
end
