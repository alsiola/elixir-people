defmodule People.UsersTest do
  use People.DataCase

  alias People.Users

  describe "user" do
    alias People.Users.User

    @valid_attrs %{
      location: "some location",
      name: "some name",
      photo: "http://photo",
      title: "some title"
    }
    @update_attrs %{
      location: "some updated location",
      name: "some updated name",
      photo: "http://updated_photo",
      title: "some updated title"
    }
    @invalid_attrs %{location: nil, name: nil, photo: nil, title: nil}
    @invalid_photo_attrs %{
      location: "some location",
      name: "some name",
      photo: "some photo",
      title: "some title"
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert Users.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.location == "some location"
      assert user.name == "some name"
      assert user.photo == "http://photo"
      assert user.title == "some title"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "create_user/1 with invalid photo returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_photo_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.location == "some updated location"
      assert user.name == "some updated name"
      assert user.photo == "http://updated_photo"
      assert user.title == "some updated title"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "update_user/2 with invalid photo returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_photo_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
