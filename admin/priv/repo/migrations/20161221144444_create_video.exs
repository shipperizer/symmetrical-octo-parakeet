defmodule Admin.Repo.Migrations.CreateVideo do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :name, :string
      add :approved_at, :utc_datetime
      add :description, :text
      add :likes, :integer
      add :views, :integer
      add :active, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:videos, [:user_id])

  end
end
