defmodule People.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :location, :string
      add :title, :string
      add :photo, :string

      timestamps()
    end
  end
end
