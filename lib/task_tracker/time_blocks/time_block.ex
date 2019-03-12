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

  def validate_stop_after_start(changeset) do
    {:ok, start} = NaiveDateTime.new(get_field(changeset, :start_date), get_field(changeset, :start_time))
    {:ok, stop} = NaiveDateTime.new(get_field(changeset, :stop_date), get_field(changeset, :stop_time))

    if Date.compare(start, stop) == :gt do
      add_error(changeset, :starts_on, "cannot be later than 'ends_on'")
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
