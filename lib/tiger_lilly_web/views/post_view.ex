defmodule TigerLillyWeb.PostView do
  use TigerLillyWeb, :view

  def format_date(date) do
    Timex.format!(date, "{0M}.{0D}.{YYYY}")
  end
end
