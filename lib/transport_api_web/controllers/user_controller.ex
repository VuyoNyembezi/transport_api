defmodule TransportApiWeb.UserController do
  use TransportApiWeb, :controller
  use Guardian, otp_app: :transport_api
  alias TransportApi.Guardian
  alias TransportApi.Accounts
  alias TransportApi.Accounts.User

  action_fallback TransportApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def signup(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> render("signedup.json", user: user )
      # |> render("jwt.json", jwt: token)
    end
  end

  def signin(email,password) do
    with {:ok, %User{} = user} <- Accounts.get_by_email(email) do
      case validate_password(password, user.password_hash) do
        true ->
          # IO.puts("signed in")
          create_token(user)
        false ->
          # IO.puts("please check input")
          {:error, :unauthorized}
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "signedup.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end




  #these functions are used for authentication
  defp validate_password(password, password_hash) do
    Pbkdf2.verify_pass(password, password_hash)
  end

  defp create_token(user) do
    {:ok, token, _claims} = Guardian.encode_and_sign(user)
    {:ok, user, token}
  end

end
