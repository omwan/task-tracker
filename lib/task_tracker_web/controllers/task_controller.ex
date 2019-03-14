defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users

  def index(conn, _params) do
    render(conn, "index.html", tasks: Tasks.list_tasks())
  end

  def new(conn, _params) do
    current_user =  get_session(conn, :user_id)
    changeset = Tasks.change_task(%Task{}, current_user)
    if current_user != nil do
      users = Users.get_subordinates(get_session(conn, :user_id))
            |> Enum.map(&{"#{&1.username}", &1.id})
      render(conn, "new.html", users: users, changeset: changeset)
    else
      render(conn, "new.html", users: [], changeset: changeset)
    end
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params, get_session(conn, :user_id)) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.get_subordinates(get_session(conn, :user_id))
                |> Enum.map(&{"#{&1.username}", &1.id})
        render(conn, "new.html", users: users, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    changeset = Tasks.change_task(task, get_session(conn, :user_id))

    if (get_session(conn, :user_id)) do
      subordinates = Users.get_subordinates(get_session(conn, :user_id))
                     |> Enum.map(&{"#{&1.username}", &1.id})
      if (task.user != nil and Enum.member?(subordinates, {task.user.username, task.user.id}))
         or task.user == nil do
        render(conn, "edit.html", task: task, users: subordinates, changeset: changeset)
      else
        render(conn, "edit.html", task: task, users: [], changeset: changeset)
      end
    else
      render(conn, "edit.html", task: task, users: [], changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task(id)

    case Tasks.update_task(task, task_params, get_session(conn, :user_id)) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Users.list_users()
                |> Enum.map(&{"#{&1.username}", &1.id})
        render(conn, "edit.html", task: task, users: users, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
