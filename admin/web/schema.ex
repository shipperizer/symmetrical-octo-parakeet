defmodule Admin.Schema do
  use Absinthe.Schema
  import_types Admin.Schema.Types

  query do
    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &Admin.UserResolver.all/2
    end

    @desc "Get a user"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &Admin.UserResolver.find/2
    end

    @desc "Get all videos"
    field :videos, list_of(:video) do
      resolve &Admin.VideoResolver.all/2
    end

    @desc "Get a video"
    field :videos, type: :video do
      arg :id, non_null(:id)
      resolve &Admin.VideoResolver.find/2
    end
  end

  mutation do
    @desc "Create a user"
    field :user, type: :user do
      arg :name, non_null(:string)
      arg :email, non_null(:string)
      arg :bio, non_null(:string)

      resolve &Admin.UserResolver.create/2
    end
  end
end
