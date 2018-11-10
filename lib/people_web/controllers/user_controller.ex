defmodule PeopleWeb.UserController do
  use PeopleWeb, :controller

  alias People.Users
  alias People.Users.User

  def index(conn, _params) do
    users = Users.list_user()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    with {validId, _} <- Integer.parse(id),
         user
         when not is_nil(user) <- Users.get_user(validId) do
      render(conn, "show.html", user: user)
    else
      nil -> show404(conn)
      :error -> show400(conn, "Invalid ID parameter")
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  defp show404(conn) do
    conn
    |> put_status(:not_found)
    |> put_view(PeopleWeb.ErrorView)
    |> render("404.html")
  end

  defp show400(conn, msg) do
    conn
    |> put_status(:bad_request)
    |> put_view(PeopleWeb.ErrorView)
    |> render("400.html", msg: msg)
  end
end
