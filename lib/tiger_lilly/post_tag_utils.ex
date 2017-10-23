defmodule TigerLilly.PostTagUtils do
  import Plug.Conn

  def assign_available_tags(conn, tags) do
    assign(conn, :available_tags, map_for_select_input(tags))
  end

  defp map_for_select_input(tags) do
    tags
    |> Enum.map(&({&1.name, &1.id}))
  end
end
