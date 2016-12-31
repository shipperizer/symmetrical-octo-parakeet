defmodule Admin.User do
  use Admin.Web, :model
  require Comeonin
  require Logger

  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :string
    field :password, :string
    has_many :videos, Admin.Video

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :bio, :password])
    |> validate_required([:name, :email, :bio, :password])
    |> validate_length(:bio, min: 2)
    |> validate_length(:bio, max: 140)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> hash_password()
  end

  @doc """
  Hash password with comeonin
  """
  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> changeset
    end
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
      password: user.password,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
