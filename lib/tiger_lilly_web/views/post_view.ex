defmodule TigerLillyWeb.PostView do
  use TigerLillyWeb, :view
  import Scrivener.HTML

  def format_date(date) do
    Timex.format!(date, "{0M}.{0D}.{YYYY}")
  end

  def as_html(text) do
    Earmark.as_html!(text)
    |> Phoenix.HTML.raw
  end
end
