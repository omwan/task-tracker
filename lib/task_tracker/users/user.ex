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

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :admin])
    |> validate_required([:username, :admin])
  end
end
