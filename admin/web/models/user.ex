defmodule Admin.User do
  use Admin.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :string
    field :pets, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :bio, :pets])
    |> validate_required([:name, :email, :bio])
    |> validate_length(:bio, min: 2)
    |> validate_length(:bio, max: 140)
    |> validate_format(:email, ~r/@/)
  end

  @doc """
  Serialize user record
  """
  def serialize(user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      bio: user.bio,
      pets: user.pets,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
