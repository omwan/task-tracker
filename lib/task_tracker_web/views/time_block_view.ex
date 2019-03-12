defmodule TaskTrackerWeb.TimeBlockView do
  use TaskTrackerWeb, :view
  alias TaskTrackerWeb.TimeBlockView

  def render("index.json", %{time_block: time_block}) do
    %{data: render_many(time_block, TimeBlockView, "time_block.json")}
  end

  def render("show.json", %{time_block: time_block}) do
    %{data: render_one(time_block, TimeBlockView, "time_block.json")}
  end

  def render("time_block.json", %{time_block: time_block}) do
    %{
      id: time_block.id,
      start_date: time_block.start_date,
      start_time: time_block.start_time,
      stop_date: time_block.stop_date,
      stop_time: time_block.stop_time
    }
  end
end
