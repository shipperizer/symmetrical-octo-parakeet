defmodule Admin.Schema.Types do
  use Absinthe.Schema.Notation

  @desc "A user of the admin"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :bio, :string
    field :videos, list_of(:video)
  end

  @desc "A user video"
  object :video do
    field :name, :string
    field :description, :string
    field :likes, :integer
    field :views, :integer
    field :active, :boolean
    field :user, :user
  end
end
