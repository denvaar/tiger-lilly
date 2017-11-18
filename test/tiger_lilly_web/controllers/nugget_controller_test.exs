defmodule TigerLillyWeb.NuggetControllerTest do
  use TigerLillyWeb.ConnCase

  alias TigerLilly.TodayILearned

  @create_attrs %{date: "2010-04-17 14:00:00.000000Z", description: "some description"}
  @update_attrs %{date: "2011-05-18 15:01:01.000000Z", description: "some updated description"}
  @invalid_attrs %{date: nil, description: nil}

  def fixture(:nugget) do
    {:ok, nugget} = TodayILearned.create_nugget(@create_attrs)
    nugget
  end

  describe "index" do
    test "lists all nuggetes", %{conn: conn} do
      conn = get conn, nugget_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Nuggetes"
    end
  end

  describe "new nugget" do
    test "renders form", %{conn: conn} do
      conn = get conn, nugget_path(conn, :new)
      assert html_response(conn, 200) =~ "New Nugget"
    end
  end

  describe "create nugget" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, nugget_path(conn, :create), nugget: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == nugget_path(conn, :show, id)

      conn = get conn, nugget_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Nugget"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, nugget_path(conn, :create), nugget: @invalid_attrs
      assert html_response(conn, 200) =~ "New Nugget"
    end
  end

  describe "edit nugget" do
    setup [:create_nugget]

    test "renders form for editing chosen nugget", %{conn: conn, nugget: nugget} do
      conn = get conn, nugget_path(conn, :edit, nugget)
      assert html_response(conn, 200) =~ "Edit Nugget"
    end
  end

  describe "update nugget" do
    setup [:create_nugget]

    test "redirects when data is valid", %{conn: conn, nugget: nugget} do
      conn = put conn, nugget_path(conn, :update, nugget), nugget: @update_attrs
      assert redirected_to(conn) == nugget_path(conn, :show, nugget)

      conn = get conn, nugget_path(conn, :show, nugget)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, nugget: nugget} do
      conn = put conn, nugget_path(conn, :update, nugget), nugget: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Nugget"
    end
  end

  describe "delete nugget" do
    setup [:create_nugget]

    test "deletes chosen nugget", %{conn: conn, nugget: nugget} do
      conn = delete conn, nugget_path(conn, :delete, nugget)
      assert redirected_to(conn) == nugget_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, nugget_path(conn, :show, nugget)
      end
    end
  end

  defp create_nugget(_) do
    nugget = fixture(:nugget)
    {:ok, nugget: nugget}
  end
end
