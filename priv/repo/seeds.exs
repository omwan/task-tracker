# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTracker.Repo.insert!(%TaskTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TaskTracker.Repo
alias TaskTracker.Users.User
alias TaskTracker.Tasks.Task
alias TaskTracker.TimeBlocks.TimeBlock

a = Repo.insert!(
  %User{
    username: "boss@example.com",
    admin: true
  }
)

b = Repo.insert!(
  %User{
    username: "manager@example.com",
    admin: true,
    manager: a
  }
)

c = Repo.insert!(
  %User{
    username: "olivia@example.com",
    admin: false,
    manager: b
  }
)

d = Repo.insert!(
  %User{
    username: "alice@example.com",
    admin: false
  }
)

t1 = Repo.insert!(
  %Task{
    name: "homework",
    description: "assignment 8",
    complete: false,
    user: c
  }
)

Repo.insert!(
  %Task{
    name: "study",
    description: "study for midterm",
    complete: false,
    user: d
  }
)

Repo.insert!(
  %TimeBlock{
    start_date: elem(Date.new(2019, 03, 11), 1),
    start_time: elem(Time.new(3, 05, 10), 1),
    stop_date: elem(Date.new(2019, 03, 11), 1),
    stop_time: elem(Time.new(3, 20, 10), 1),
    task: t1
  }
)

Repo.insert!(
  %TimeBlock{
    start_date: elem(Date.new(2019, 03, 12), 1),
    start_time: elem(Time.new(4, 05, 10), 1),
    stop_date: elem(Date.new(2019, 03, 12), 1),
    stop_time: elem(Time.new(4, 20, 10), 1),
    task: t1
  }
)