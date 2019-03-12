defmodule TaskTracker.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "time_block" do
    field :start, :utc_datetime
    field :stop, :utc_datetime
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start, :stop, :task_id])
    |> validate_required([:start, :stop, :task_id])
  end
end
