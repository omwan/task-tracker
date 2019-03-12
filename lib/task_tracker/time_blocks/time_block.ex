defmodule TaskTracker.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "time_block" do
    field :start_date, :date
    field :start_time, :time
    field :stop_date, :date
    field :stop_time, :time
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start_date, :start_time, :stop_date, :stop_time, :task_id])
    |> validate_required([:start_date, :start_time, :stop_date, :stop_time, :task_id])
  end
end
