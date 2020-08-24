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

  # web/controllers/user_controller.ex
  def update(conn, %{"id" => id} = params) do
    user = ApiExample.Repo.get(ApiExample.User, id)
    if user do
      perform_update(conn, user, params)
    else
      json conn |> put_status(:not_found),
                   %{errors: ["invalid user"]}
    end
  end

  def delete(conn, %{"id" => id} = params) do
    user = ApiExample.Repo.get(ApiExample.User, id)
    if user do
      perform_delete(conn, user, params)
    else
      json conn |> put_status(:not_found),
                   %{erros: ["Invalid User"]}
    end
  end

defp perform_delete(conn, user, params) do
  changeset = ApiExample.User.changeset(user, params)
  case ApiExample.Repo.delete(changeset) do
    {:ok, user} ->
      json conn |> put_status(:ok), user
    {:error, _result} ->
      json conn |> put_status(:bad_request),
                   %{errors: ["unable to update user"]}
  end
end

defp perform_update(conn, user, params) do
  changeset = ApiExample.User.changeset(user, params)
  case ApiExample.Repo.update(changeset) do
    {:ok, user} ->
      json conn |> put_status(:ok), user
    {:error, _result} ->
      json conn |> put_status(:bad_request),
                   %{errors: ["unable to update user"]}
  end
end

end
