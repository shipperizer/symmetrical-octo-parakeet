defmodule Admin.VideoResolver do
  alias Admin.Video

  def all(_args, _info) do
    {:ok, Admin.Repo.all(Video)}
  end

  def find(%{id: id}, _info) do
    case Admin.Repo.get(Video, id) do
      nil  -> {:error, "Video id #{id} not found"}
      video -> {:ok, video}
    end
  end

  def create(args, _info) do
    %Video{}
    |> Video.changeset(args)
    |> Admin.Repo.insert
  end
end
