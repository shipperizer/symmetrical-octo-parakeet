defmodule Admin.Video do
  use Admin.Web, :model

  schema "videos" do
    field :name, :string
    field :approved_at, Ecto.DateTime
    field :description, :string
    field :likes, :integer
    field :views, :integer
    field :active, :boolean, default: false
    belongs_to :user, Admin.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :approved_at, :description, :likes, :views, :active, :user_id])
    |> validate_required([:name, :approved_at, :description, :likes, :views, :active, :user_id])
  end
end
