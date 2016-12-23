defmodule Admin.UserResolver do
  alias Admin.User

  def all(_args, _info) do
    {:ok, Admin.Repo.all(User) |> Admin.Repo.preload([:videos])}
  end

  def find(%{id: id}, _info) do
    case Admin.Repo.get(User, id) |> Admin.Repo.preload([:videos]) do
      nil  -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def create(args, _info) do
    %User{}
    |> User.changeset(args)
    |> Admin.Repo.insert
  end
end
