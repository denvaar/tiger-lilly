defmodule TigerLillyWeb.PostView do
  use TigerLillyWeb, :view
  import Scrivener.HTML

  def format_date(date) do
    Timex.format!(date, "{0M}.{0D}.{YYYY}")
  end

  def as_html(nil), do: nil
  def as_html(text) do
    Earmark.as_html!(text)
    |> Phoenix.HTML.raw
  end

  def extra_query_params(params) do
    params
    |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
    |> Enum.reject(fn {key, _} -> key == :page end)
    |> Enum.reject(fn {_, value} -> value == "" end)
  end
end
