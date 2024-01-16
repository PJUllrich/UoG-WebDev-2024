defmodule Movies.TempsTest do
  use Movies.DataCase

  alias Movies.Temps

  describe "temperatures" do
    alias Movies.Temps.Temp

    import Movies.TempsFixtures

    @invalid_attrs %{value: nil}

    test "list_temperatures/0 returns all temperatures" do
      temp = temp_fixture()
      assert Temps.list_temperatures() == [temp]
    end

    test "get_temp!/1 returns the temp with given id" do
      temp = temp_fixture()
      assert Temps.get_temp!(temp.id) == temp
    end

    test "create_temp/1 with valid data creates a temp" do
      valid_attrs = %{value: 42}

      assert {:ok, %Temp{} = temp} = Temps.create_temp(valid_attrs)
      assert temp.value == 42
    end

    test "create_temp/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Temps.create_temp(@invalid_attrs)
    end

    test "update_temp/2 with valid data updates the temp" do
      temp = temp_fixture()
      update_attrs = %{value: 43}

      assert {:ok, %Temp{} = temp} = Temps.update_temp(temp, update_attrs)
      assert temp.value == 43
    end

    test "update_temp/2 with invalid data returns error changeset" do
      temp = temp_fixture()
      assert {:error, %Ecto.Changeset{}} = Temps.update_temp(temp, @invalid_attrs)
      assert temp == Temps.get_temp!(temp.id)
    end

    test "delete_temp/1 deletes the temp" do
      temp = temp_fixture()
      assert {:ok, %Temp{}} = Temps.delete_temp(temp)
      assert_raise Ecto.NoResultsError, fn -> Temps.get_temp!(temp.id) end
    end

    test "change_temp/1 returns a temp changeset" do
      temp = temp_fixture()
      assert %Ecto.Changeset{} = Temps.change_temp(temp)
    end
  end
end
