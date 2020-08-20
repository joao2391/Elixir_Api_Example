defmodule ApiExample.UserController do
  @moduledoc """
  Creating an user
  """
  use ApiExampleWeb, :controller

  def index(conn, _params) do
    users = ApiExample.Repo.all(ApiExample.User)

    json conn, users
  end

  def show(conn, %{"id" => id}) do
    user = ApiExample.Repo.get(ApiExample.User, String.to_integer(id))

    json conn, user
  end

  def create(conn, params) do
    changeset = ApiExample.User.changeset(%ApiExample.User{}, params)
      case ApiExample.Repo.insert(changeset) do
      {:ok, user} ->
        json conn |> put_status(:created), user
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to create user"] }
      end
  end

end
