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

{:ok, d1} = DateTime.from_unix(1_552_356_186)
{:ok, d2} = DateTime.from_unix(1_552_356_372)

Repo.insert!(%TimeBlock{start: d1, stop: d2, task: t1})

{:ok, d3} = DateTime.from_unix(1_552_356_584)
{:ok, d4} = DateTime.from_unix(1_552_356_606)

Repo.insert!(%TimeBlock{start: d3, stop: d4, task: t1})