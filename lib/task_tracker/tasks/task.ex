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

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :complete, :user_id])
    |> validate_required([:name, :complete])
  end
end
