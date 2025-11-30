defmodule EasyDashWeb.AuthController do
  use EasyDashWeb, :controller

  def login(conn, %{"email" => email, "password" => password}) do
    case EasyDash.Accounts.get_user_by_email_and_password(email, password) do
      {:ok, user} ->
        token = Phoenix.Token.sign(conn, "d@n13l", user.id)
        conn |> put_status(:ok) |> json(%{token: token, user_id: user.id, email: user.email})

      {:error, _reason} ->
        conn |> put_status(:unauthorized) |> json(%{error: "Email ou senha inválidos"})
    end
  end
end
