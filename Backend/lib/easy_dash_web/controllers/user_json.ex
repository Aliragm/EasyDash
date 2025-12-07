defmodule EasyDashWeb.UserJSON do
  alias EasyDash.Accounts.User

  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      inserted_at: user.inserted_at
    }
  end
end
