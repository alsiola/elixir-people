defmodule People.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "user" do
    field :location, :string
    field :name, :string
    field :photo, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :location, :role, :photo])
    |> validate_required([:name, :location, :role, :photo])
  end
end
