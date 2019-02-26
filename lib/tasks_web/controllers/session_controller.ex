defmodule TasksWeb.SessionController do
  use TasksWeb, :controller

  # Referenced from lecture code
  # https://github.com/NatTuck/husky_shop/compare/2-deploy...3-users#diff-501b6001d573b9bc1ffba704a1bdc907

  def create(conn, %{"username" => username}) do
    user = Tasks.Users.get_user_by_username(username)

    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back #{user.username}")
      |> redirect(to: page_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Login failed")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end

end