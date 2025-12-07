defmodule EasyDashWeb.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> verify_token(conn, token)
      _ -> unauthorized(conn)
    end
  end

  defp verify_token(conn, token) do
    case Phoenix.Token.verify(conn, "d@n13l", token, max_age: 900_000) do
      {:ok, user_id} ->
        assign(conn, :current_user_id, user_id)
      {:error, _reason} ->
        unauthorized(conn)
    end
  end

  defp unauthorized(conn) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "Acesso negado. Faça login"})
    |> halt()
  end
end
