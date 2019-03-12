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

  def compare_datetimes(changeset) do
    {:ok, start_naive} = NaiveDateTime.new(get_field(changeset, :start_date), get_field(changeset, :start_time))
    {:ok, stop_naive} = NaiveDateTime.new(get_field(changeset, :stop_date), get_field(changeset, :stop_time))

    {:ok, start} = DateTime.from_naive(start_naive, "Etc/UTC")
    {:ok, stop} = DateTime.from_naive(stop_naive, "Etc/UTC")

    DateTime.compare(start, stop)
  end

  def validate_stop_after_start(changeset) do
    if compare_datetimes(changeset) == :gt do
      add_error(changeset, :start_date, "Stop date and time cannot be before start date and time")
    else
      changeset
    end
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start_date, :start_time, :stop_date, :stop_time, :task_id])
    |> validate_required([:start_date, :start_time, :stop_date, :stop_time, :task_id])
    |> validate_stop_after_start()
  end
end
