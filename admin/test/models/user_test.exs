defmodule Admin.UserTest do
  use Admin.ModelCase

  alias Admin.User

  @valid_attrs %{bio: "some content", email: "some content", name: "some content", pets: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
