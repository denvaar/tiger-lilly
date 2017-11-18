defmodule TigerLilly.TodayILearnedTest do
  use TigerLilly.DataCase

  alias TigerLilly.TodayILearned

  describe "nuggetes" do
    alias TigerLilly.TodayILearned.Nugget

    @valid_attrs %{date: "2010-04-17 14:00:00.000000Z", description: "some description"}
    @update_attrs %{date: "2011-05-18 15:01:01.000000Z", description: "some updated description"}
    @invalid_attrs %{date: nil, description: nil}

    def nugget_fixture(attrs \\ %{}) do
      {:ok, nugget} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TodayILearned.create_nugget()

      nugget
    end

    test "list_nuggetes/0 returns all nuggetes" do
      nugget = nugget_fixture()
      assert TodayILearned.list_nuggetes() == [nugget]
    end

    test "get_nugget!/1 returns the nugget with given id" do
      nugget = nugget_fixture()
      assert TodayILearned.get_nugget!(nugget.id) == nugget
    end

    test "create_nugget/1 with valid data creates a nugget" do
      assert {:ok, %Nugget{} = nugget} = TodayILearned.create_nugget(@valid_attrs)
      assert nugget.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert nugget.description == "some description"
    end

    test "create_nugget/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TodayILearned.create_nugget(@invalid_attrs)
    end

    test "update_nugget/2 with valid data updates the nugget" do
      nugget = nugget_fixture()
      assert {:ok, nugget} = TodayILearned.update_nugget(nugget, @update_attrs)
      assert %Nugget{} = nugget
      assert nugget.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert nugget.description == "some updated description"
    end

    test "update_nugget/2 with invalid data returns error changeset" do
      nugget = nugget_fixture()
      assert {:error, %Ecto.Changeset{}} = TodayILearned.update_nugget(nugget, @invalid_attrs)
      assert nugget == TodayILearned.get_nugget!(nugget.id)
    end

    test "delete_nugget/1 deletes the nugget" do
      nugget = nugget_fixture()
      assert {:ok, %Nugget{}} = TodayILearned.delete_nugget(nugget)
      assert_raise Ecto.NoResultsError, fn -> TodayILearned.get_nugget!(nugget.id) end
    end

    test "change_nugget/1 returns a nugget changeset" do
      nugget = nugget_fixture()
      assert %Ecto.Changeset{} = TodayILearned.change_nugget(nugget)
    end
  end
end
