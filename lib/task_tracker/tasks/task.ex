defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :name, :string
    field :time_spent, :integer
    field :assignee_id, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :time_spent, :assignee_id])
    |> validate_required([:name, :time_spent])
  end
end
