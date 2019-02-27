defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :name, :string
    field :complete, :boolean
    field :time_spent, :integer
    belongs_to :user, TaskTracker.Users.User

    timestamps()
  end

  defp validate_increment(changeset, field, increment) do
    case changeset.valid? do
      true ->
        value = get_field(changeset, field)
        case rem(value, increment) == 0 do
          true -> changeset
          _ -> add_error(changeset, :time_spent, "must be a multiple of #{increment}")
        end
      _ ->
        changeset
    end
  end


  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :time_spent, :complete, :user_id])
    |> validate_required([:name, :complete, :time_spent])
    |> validate_number(:time_spent, greater_than_or_equal_to: 0)
    |> validate_increment(:time_spent, 15)
  end
end
