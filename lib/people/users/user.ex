defmodule People.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :location, :string
    field :name, :string
    field :photo, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :location, :title, :photo])
    |> validate_required([:name, :location, :title, :photo])
    |> validate_format(:photo, ~r/^http[s]?:\/\//, message: "Must begin with http://")
  end
end
