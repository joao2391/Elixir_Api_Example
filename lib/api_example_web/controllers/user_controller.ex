defmodule ApiExample.UserController do
  use ApiExampleWeb, :controller

  def index(conn, _params) do
    users = ApiExample.Repo.all(ApiExample.User)

    json conn, users
  end

  def show(conn, %{"id" => id}) do
    user = ApiExample.Repo.get(ApiExample.User, String.to_integer(id))

    json conn, user
  end

  def create(conn, %{"name" => name, "email" => email, "password" => password, "stooge" => stooge}) do

    %ApiExample.User{
      name: name,
      email: email,
      password: password,
      stooge: stooge
    }
    user = ApiExample.Repo.insert!(ApiExample.User)

    conn
    |> send_resp(200, "ok")
  end
end
