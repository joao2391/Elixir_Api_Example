# defmodule ApiExample.Repo.Migrations.CreateUser do
#   use Ecto.Migration

#   def change do

#   end
# end

# priv/repo/migrations/<timestamp>_create_user.exs
defmodule ApiExample.Repo.Migrations.CreateUser do
  use Ecto.Migration
  def change do
    create table(:users) do
      add :name, :string
      add :password, :string
      add :email, :string
      add :stooge, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
