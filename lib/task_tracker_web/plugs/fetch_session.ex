defmodule TaskTrackerWeb.Plugs.FetchSession do
  import Plug.Conn

  # Referenced from lecture code
  # https://github.com/NatTuck/husky_shop/compare/2-deploy...3-users#diff-2c6d7e4b7b6ebe78b01a8847ad5ac5bc

  def init(args) do
    args
  end

  def call(conn, _args) do
    user = TaskTracker.Users.get_user(get_session(conn, :user_id) || -1)
    if user do
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

end