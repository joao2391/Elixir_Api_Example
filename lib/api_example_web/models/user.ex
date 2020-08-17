defmodule ApiExample.User do
  use Ecto.Schema
  @derive {Jason.Encoder, only: [:name, :email,:password, :stooge]}
  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :stooge, :string

    timestamps(type: :utc_datetime)
  end
  #@derive Jason.Encoder
  #defstruct [:id, :name, :email, :password, :stooge]

  def changeset(users, params \\ %{}) do
    users
    |> Ecto.Changeset.cast(params, [:name, :email, :password, :stooge])
  end

end
